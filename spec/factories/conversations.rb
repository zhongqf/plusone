# == Schema Information
#
# Table name: conversations
#
#  id              :integer(4)      not null, primary key
#  user_id         :integer(4)
#  group_id        :integer(4)
#  title           :string(255)
#  body            :text
#  body_html       :text
#  comments_count  :integer(4)
#  last_comment_id :integer(4)
#  is_archived     :boolean(1)
#  is_public       :boolean(1)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :conversation do
    end
end
