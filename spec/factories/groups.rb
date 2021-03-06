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

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
    association :creator, factory: :user
    association :manager, factory: :user
    name { FactoryGirl.generate(:name)}
    type "Group"
    is_archived false
    is_public true
    description "Description here"
    settings nil
  end
end
