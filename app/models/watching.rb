# == Schema Information
#
# Table name: watchings
#
#  id             :integer(4)      not null, primary key
#  watchable_id   :integer(4)
#  watchable_type :string(255)
#  user_id        :integer(4)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

class Watching < ActiveRecord::Base
  belongs_to :watchable, :polymorphic => true
  belongs_to :user
end
