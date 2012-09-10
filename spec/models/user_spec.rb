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

require 'spec_helper'

describe User do
  
  
  describe "factories" do
    it "should generate a valid user" do
      user = factory!(:user)
      user.valid?.should be_true
    end
  end
end
