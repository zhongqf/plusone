# == Schema Information
#
# Table name: companies
#
#  id                :integer(4)      not null, primary key
#  name              :string(255)
#  permalink         :string(255)
#  logo_file_name    :string(255)
#  logo_content_type :string(255)
#  logo_file_size    :integer(4)
#  logo_updated_at   :datetime
#  login_instruction :text
#  default_language  :string(255)
#  default_time_zone :string(255)
#  description       :text
#  settings          :text
#  domain            :string(255)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#

require 'spec_helper'

describe Company do
  
  it { should have_many(:people) }
  it { should have_many(:groups) }
  it { should have_many(:users) }
  it { should have_many(:employees) }
  it { should have_many(:clients) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:permalink) }
  it { should ensure_length_of(:name).is_at_least(3).is_at_most(40) }
  it { should ensure_length_of(:permalink).is_at_least(3).is_at_most(16) }

  #permalink_format
  
  describe "create" do
    #it "should be created when new company user created" do
    #  
    #  user = FactoryGirl.build(:user, :email => "user@company.com")
    #  lambda {
    #    user.save
    #  }.should change(described_class, :count)
    #  
    #  company = Company.last
    #  user.company.should == company
    #  company.has_people?(user).should == true
    #  company.domain.should == "company.com"
    #  company.permalink.should =="company.com"
    #  company.name.should == "company.com"
    #  
    #end
    #
    #it "should not create when exist company" do
    #  company = factory!(:company, :domain => "existed.com")
    #  user = FactoryGirl.build(:user, :email => "user@existed.com")
    #  
    #  lambda {
    #    user.save
    #  }.should_not change(described_class, :count)
    #  
    #  user.company.should == company
    #end
  end
  
  describe "destroy" do
    it "should destroy people but not destroy user" do
      user = factory!(:user)
      company = factory!(:company)
      
      company.add_employee!(user)
      person = Person.where(:company_id => company.id, :user_id => user.id, :is_employee => true).first
      person.valid?.should == true
      
      company.destroy
      
      lambda { Company.find(company.id) }.should raise_error(ActiveRecord::RecordNotFound)
      lambda { User.find(user.id) }.should_not raise_error
      lambda { Person.find(person.id) }.should raise_error(ActiveRecord::RecordNotFound)
      
    end
    
    it "should destroy contents" do
    end
  end
  
  
  describe "factories" do
    it "should generate a valid company" do
      company = factory!(:company)
      company.valid?.should be_true
    end
  end
end
