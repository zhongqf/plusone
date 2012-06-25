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

require 'spec_helper'

describe Member do
  pending "add some examples to (or delete) #{__FILE__}"  
end
