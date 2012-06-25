# == Schema Information
#
# Table name: contact_items
#
#  id           :integer(4)      not null, primary key
#  profile_id   :integer(4)
#  contact_type :integer(4)
#  value        :string(255)
#  note         :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact_item do
    end
end
