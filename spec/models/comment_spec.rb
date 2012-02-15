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

require 'spec_helper'

describe Comment do
  
  it { should belong_to(:user) }
  it { should belong_to(:context)}
  it { should belong_to(:commentable)}

  describe "factories" do
    it "should generate a valid comment" do
      comment = FactoryGirl.build(:comment)
      comment.valid?.should be_true
    end
    
    it "should not allow comment creation with a blank title" do
      comment = FactoryGirl.build(:comment, :body => nil)
      comment.should_not be_valid
    end
  end
  
end
