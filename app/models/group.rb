# == Schema Information
#
# Table name: groups
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  company_id  :integer(4)
#  name        :string(255)
#  permalink   :string(255)
#  is_archived :boolean(1)
#  is_public   :boolean(1)
#  description :text
#  settings    :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Group < ActiveRecord::Base
  belongs_to :user
  belongs_to :company
  has_many :members

  validates_presence_of :name
  validates_presence_of :permalink
  validates_length_of :name, :within => 3..40
  validates_length_of :permalink, :within => 3..16
    
  scope :archived, where(:is_archived => true)
  scope :active, where(:is_archived => false)
  scope :public, where(:is_public => true)
  scope :private, where(:is_public => false)
  
  after_create :log_create
  
  def archive!
    update_attribute(:is_archived, true)
  end
  
  def add_member!(user, member_type = Member::TYPES[:participant])
    unless has_member?(user)
      members.create do |member|
        member.user = user
        member.member_type = member_type
      end
    end
  end
  
  def remove_member!(user)
    members.find_by_user_id(user.id).try(:destroy)
  end
  
  def has_member?(user)
    members.exists?(:user_id => user.id)
  end
  
  def members_count
    members.count
  end
  
  def admin?(user)
    members.exists?(:user_id => user.id, :member_type => Member::TYPES[:admin])
  end
  
  def owner?(user)
    self.user == user
  end
  
  def log_create
    company.log_activity(self, "create") if is_public
  end
  
  def log_activity(target, action, user = nil)
    user ||= target.try(:user)
    Activity.log(self, target, action, user)
  end
end
