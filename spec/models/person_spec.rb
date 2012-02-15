# == Schema Information
#
# Table name: people
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  company_id  :integer(4)
#  is_employee :boolean(1)
#  is_admin    :boolean(1)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'spec_helper'

describe Person do
  before do
    @company = factory!(:company)
    @user = factory!(:user)
    
    @company1 = factory!(:company)
    @company2 = factory!(:company)
    
    @user1 = factory!(:user)
    @user2 = factory!(:user)
  end
  
  it { should belong_to(:company) }
  it { should belong_to(:user) }
  
  
  describe "create" do

    it "should add employees to a company" do
      
      @user1.company.should == nil
      @user2.company.should == nil
      
      @company.add_employee!(@user1)
      @user1.company.should == @company
      @company.has_person?(@user1).should == true
      @company.has_employee?(@user1).should == true
      @company.has_client?(@user1).should == false
      @company.employees.count.should == 1
      
      @company.add_employee!(@user2)
      @user2.company.should == @company
      @company.has_person?(@user2).should == true
      @company.has_employee?(@user2).should == true
      @company.has_client?(@user2).should == false
      @company.employees.count.should == 2
      
      @company.clients.count.should == 0
      
    end
    
    it "should add clients to a company" do
      
      @user1.company.should == nil
      @user2.company.should == nil
      
      @company.add_client!(@user1)
      @user1.company.should == nil
      @company.has_person?(@user1).should == true
      @company.has_employee?(@user1).should == false
      @company.has_client?(@user1).should == true
      @company.clients.count.should == 1
      
      @company.add_client!(@user2)
      @user2.company.should == nil
      @company.has_person?(@user2).should == true
      @company.has_employee?(@user2).should == false
      @company.has_client?(@user2).should == true
      @company.clients.count.should == 2
      
      @company.employees.count.should == 0      
    end
    
    it "should not add a user to multi company as employee" do
      
      @company1.add_employee!(@user)
      @company2.add_employee!(@user)
      
      @user.company.should == @company1
      @company2.has_person?(@user).should == false
      @company2.has_employee?(@user).should == false
      @company2.has_client?(@user).should == false
      @company2.employees.count.should == 0
      @company2.clients.count.should == 0
    end
    
    it "should add a user to multi company as client" do
      @company1.add_client!(@user)
      @company2.add_client!(@user)
      
      @user.company.should == nil
      
      @company1.has_person?(@user).should == true
      @company2.has_person?(@user).should == true
      @company1.has_employee?(@user).should == false
      @company2.has_employee?(@user).should == false
      @company1.has_client?(@user).should == true
      @company2.has_client?(@user).should == true
      @company1.clients.count.should == 1
      @company2.clients.count.should == 1
    end
    
    it "should not add an employee to his company as client" do
      @company.add_employee!(@user)
      @company.add_client!(@user)
      
      @user.company.should == @company
      @company.has_employee?(@user).should == true
      @company.has_client?(@user).should == false
      @company.employees.count.should == 1
      @company.clients.count.should == 0
    end
    
    it "should add a client to the company as employee" do

      @company.add_client!(@user)
      @company.add_employee!(@user)
      
      @user.company.should == @company
      @company.has_employee?(@user).should == true
      @company.has_client?(@user).should == false
      @company.employees.count.should == 1
      @company.clients.count.should == 0     
    end
    
  end
  
  describe "destroy" do
    it "should remove employee or client from company" do
      
      @company1.add_employee!(@user1)
      @company1.add_client!(@user2)
      
      @company2.add_client!(@user1)
      @company2.add_employee!(@user2)
      
      @company1.remove_person!(@user1)
      @company2.remove_person!(@user1)
      
      @user1.company.should == nil
      @user2.company.should == @company2
      
      @company1.has_employee?(@user1).should == false
      @company1.has_client?(@user1).should == false
      @company1.has_employee?(@user2).should == false
      @company1.has_client?(@user2).should == true

      @company2.has_employee?(@user1).should == false
      @company2.has_client?(@user1).should == false
      @company2.has_employee?(@user2).should == true
      @company2.has_client?(@user2).should == false
    end
  end
  
  
  describe "activities" do
    it "should log activity when employed by company" do
      
      lambda {
        @company.add_employee!(@user)
      }.should change(Activity, :count).by(1)
      
      last = Activity.last
      last.action.should == "create"
      last.target.should == Person.where(:company_id => @company.id, :user_id => @user.id, :is_employee => true).first
      last.context.should == @company

    end
    it "should not log activity when join company as client" do
      lambda {
        @company.add_client!(@user)
      }.should_not change(Activity, :count)
    end
    
    # it "should log activity when leaving company?"
  end
  
  
end
