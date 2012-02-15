# == Schema Information
#
# Table name: members
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  group_id    :integer(4)
#  member_type :integer(4)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Member < ActiveRecord::Base
  
  TYPES = {:participant => 2, :admin => 3}
  
  scope :admin, where(:member_type => TYPES[:admin])
  scope :participant, where(:member_type => TYPES[:participant])
  
  
  belongs_to :user
  belongs_to :group
  
  after_create :log_create
  
  def admin?
    group.admin?(user)
  end
  
  def owner?
    group.owner?(user)
  end
  
  
  def log_create
    group.log_activity(self, "create")
  end
  
end
