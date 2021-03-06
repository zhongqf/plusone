# == Schema Information
#
# Table name: members
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  group_id   :integer(4)
#  is_admin   :boolean(1)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Member < ActiveRecord::Base
  
  scope :admin, where(:is_admin => true)
  scope :participant, where(:is_admin => false)
  
  
  belongs_to :user
  belongs_to :group
  
  
  def admin?
    group.admin?(user)
  end
  
  def log_create
    #group.log_activity(self, "create")
  end
  
end
