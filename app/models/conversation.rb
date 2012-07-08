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

class Conversation < ActiveRecord::Base
  has_many :comments, :as => :commentable

  belongs_to :user
  belongs_to :group
  belongs_to :last_comment, :class_name => "Comment"

  validates_presence_of :body

end
