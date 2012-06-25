# == Schema Information
#
# Table name: comments
#
#  id               :integer(4)      not null, primary key
#  commentable_id   :integer(4)
#  commentable_type :string(255)
#  group_id         :integer(4)
#  user_id          :integer(4)
#  body             :text
#  body_html        :text
#  is_public        :boolean(1)      default(TRUE), not null
#  extrainfo        :text
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

require 'spec_helper'

describe Comment do
  pending "add some examples to (or delete) #{__FILE__}"
end
