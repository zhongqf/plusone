# == Schema Information
#
# Table name: groups
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  company_id  :integer(4)
#  name        :string(255)
#  permalink   :string(255)
#  is_archived :boolean(1)
#  is_public   :boolean(1)
#  description :text
#  settings    :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'spec_helper'

describe Group do
  
  before do
    @company = factory!(:company)
    @user = factory!(:user)
  end
  
  it { should belong_to(:user) }
  it { should belong_to(:company) }
  it { should have_many(:members) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:permalink) }
  it { should ensure_length_of(:name).is_at_least(3).is_at_most(40) }
  it { should ensure_length_of(:permalink).is_at_least(3).is_at_most(16) }
  
  
  describe "create" do 
    it "should add a group in a company" do
      
    end
  end
  
  describe "activities" do
    it "should log activity when creating a public group" do
      lambda {
        @group = factory!(:group, :company => @company, :user => @user, :is_public => true)
      }.should change(Activity, :count).by(1)
      
      last = Activity.last
      last.action.should == "create"
      last.target.should == @group
      last.context.should == @company
      last.user.should == @user
    end
    
    it "should not log activity when creating a private group" do
      lambda {
        @group = factory!(:group, :company => @company, :user => @user, :is_public => false)
      }.should_not change(Activity, :count)
    end
  end
end
