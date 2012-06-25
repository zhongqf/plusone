# == Schema Information
#
# Table name: groups
#
#  id          :integer(4)      not null, primary key
#  creator_id  :integer(4)
#  manager_id  :integer(4)
#  type        :string(255)
#  name        :string(255)
#  is_archived :boolean(1)
#  is_public   :boolean(1)
#  description :text
#  settings    :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Group < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  belongs_to :manager, :class_name => "User"
  has_many :members

  validates_presence_of :name
  validates_length_of :name, :within => 3..40
    
  scope :archived, where(:is_archived => true)
  scope :active, where(:is_archived => false)
  scope :public, where(:is_public => true)
  scope :private, where(:is_public => false)
  
  def archive!
    update_attribute(:is_archived, true)
  end
  
  def add_member!(user, is_admin = false)
    unless has_member?(user)
      members.create do |member|
        member.user = user
        member.is_admin = is_admin
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
    members.exists?(:user_id => user.id, :is_admin => true)
  end
  
  def log_create
  end
  
  def log_activity(target, action, user = nil)
    user ||= target.try(:user)
    Activity.log(self, target, action, user)
  end
end
