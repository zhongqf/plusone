# == Schema Information
#
# Table name: activities
#
#  id               :integer(4)      not null, primary key
#  group_id         :integer(4)
#  user_id          :integer(4)
#  action           :string(255)
#  target_type      :string(255)
#  target_id        :integer(4)
#  link_object_type :string(255)
#  link_object_id   :integer(4)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    end
end
