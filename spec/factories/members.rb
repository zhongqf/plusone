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

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member do
    user
    group
    member_type 0
  end
end
