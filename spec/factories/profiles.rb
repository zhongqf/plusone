# == Schema Information
#
# Table name: profiles
#
#  id                  :integer(4)      not null, primary key
#  user_id             :integer(4)
#  email               :string(255)
#  first_name          :string(255)
#  last_name           :string(255)
#  name                :string(255)
#  bio                 :text
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer(4)
#  avatar_updated_at   :datetime
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
  end
end
