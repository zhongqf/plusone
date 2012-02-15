# == Schema Information
#
# Table name: comments
#
#  id               :integer(4)      not null, primary key
#  commentable_id   :integer(4)
#  commentable_type :string(255)
#  context_id       :integer(4)
#  context_type     :string(255)
#  user_id          :integer(4)
#  body             :text
#  body_html        :text
#  is_public        :boolean(1)      default(TRUE), not null
#  extrainfo        :text
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :context, :polymorphic => true
  belongs_to :user
  
  validates_presence_of :body
end
