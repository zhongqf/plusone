# == Schema Information
#
# Table name: companies
#
#  id                :integer(4)      not null, primary key
#  name              :string(255)
#  permalink         :string(255)
#  logo_file_name    :string(255)
#  logo_content_type :string(255)
#  logo_file_size    :integer(4)
#  logo_updated_at   :datetime
#  login_instruction :text
#  default_language  :string(255)
#  default_time_zone :string(255)
#  description       :text
#  settings          :text
#  domain            :string(255)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
    name { FactoryGirl.generate(:name)}
    permalink { FactoryGirl.generate(:permalink)}
    logo_file_name "MyString"
    logo_content_type "MyString"
    logo_file_size 1
    logo_updated_at "2011-11-03 22:59:40"
    login_instruction "MyText"
    default_language "MyString"
    default_time_zone "MyString"
    description "MyText"
    settings "MyText"
    domain "MyString"
  end
end
