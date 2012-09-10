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

FactoryGirl.define do
  factory :organization do
    end
end
