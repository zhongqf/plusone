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

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    user
    company
    is_employee true
    is_admin false
  end
end
