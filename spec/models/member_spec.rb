# == Schema Information
#
# Table name: members
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  group_id    :integer(4)
#  member_type :integer(4)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'spec_helper'

describe Member do
  before do
    @group = factory!(:group)
    @user = factory!(:user)
    
    @group1 = factory!(:group)
    @group2 = factory!(:group)
    
    @user1 = factory!(:user)
    @user2 = factory!(:user)
  end
  
  it { should belong_to(:group) }
  it { should belong_to(:user) }
  
  describe "create" do

    it "should add member to a group" do
      @user1.groups.should be_blank
      @user2.groups.should be_blank

      @group1.add_member!(@user1)
      @group1.add_member!(@user2)
      @group2.add_member!(@user1)
      @group2.add_member!(@user1)
      
      @user1.reload
      @user2.reload

      @user1.groups.include?(@group1).should == true
      @user1.groups.include?(@group2).should == true
      @user2.groups.include?(@group1).should == true
      @user2.groups.include?(@group2).should == false
      
      @group1.has_member?(@user1).should == true
      @group1.has_member?(@user2).should == true
      @group2.has_member?(@user1).should == true
      @group2.has_member?(@user2).should == false
      
      @group1.members_count.should == 2
      @group2.members_count.should == 1
    end
    
    it "should remove member from a group" do
      @group1.add_member!(@user1)
      @group1.add_member!(@user2)
      
      @user1.reload
      @user2.reload
      
      @group1.remove_member!(@user1)
      
      @user1.groups.include?(@group1).should == false
      @group1.has_member?(@user1).should == false
      @user2.groups.include?(@group1).should == true
      @group1.has_member?(@user2).should == true
      
      @group1.remove_member!(@user1)
      @group1.members_count.should == 1
      
      @group1.remove_member!(@user2)
      @user2.groups.include?(@group1).should == false
      @group1.has_member?(@user2).should == false
      
    end
  end
  
  describe "activities" do
    it "should log activity when joining group" do
      
      lambda {
        @group.add_member!(@user)
      }.should change(Activity, :count).by(1)
      
      last = Activity.last
      last.action.should == "create"
      last.target.should == Member.where(:group_id => @group.id, :user_id => @user.id).first
      last.context.should == @group

    end
    
    # it "should log activity when leaving group?"
  end
  

end
