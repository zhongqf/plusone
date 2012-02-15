# == Schema Information
#
# Table name: people
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  company_id  :integer(4)
#  is_employee :boolean(1)
#  is_admin    :boolean(1)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Person < ActiveRecord::Base
  belongs_to :user
  belongs_to :company
  
  scope :employee, where(:is_employee => true)
  scope :admin, where(:is_admin => true)
  
  after_create :log_create
  
  def admin?
    company.admin?(user)
  end
  
  def employee?
    company.has_employee?(user)
  end
  
  
  def log_create
    company.log_activity(self, "create") if is_employee
  end
end
