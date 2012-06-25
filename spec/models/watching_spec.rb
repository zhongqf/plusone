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

require 'spec_helper'

describe Watching do
  pending "add some examples to (or delete) #{__FILE__}"
end
