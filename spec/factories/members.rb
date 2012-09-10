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

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member do
    ignore {
      user_name { FactoryGirl.generate(:name) }
      group_name { FactoryGirl.generate(:name) }
    }
    
    user nil
    group nil
    is_admin false

    after(:build) do |member, eva|
      member.group = Group.find_by_name(eva.group_name) || FactoryGirl.build(:group, :name => eva.group_name)

      if p = Profile.find_by_name(eva.user_name)
        member.user = p.user
      else
        member.user = FactoryGirl.build(:user, :name => eva.user_name)
      end
    end
    
  end
end
