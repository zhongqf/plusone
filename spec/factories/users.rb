# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  identity               :string(255)
#  is_admin               :boolean(1)      default(FALSE), not null
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  organization_group_id  :integer(4)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    ignore {
      name { FactoryGirl.generate(:name) }
    }
    
    identity { FactoryGirl.generate(:identity)}
    email { name.parameterize("_") + "@plusone.com"}
    password "papapa"
    password_confirmation "papapa"
    profile nil

    after(:build) do |user, eva|
      user.profile = Profile.find_by_name(eva.name) || FactoryGirl.build(:profile, :name => eva.name, :email => eva.email)
    end
    
  end
end

