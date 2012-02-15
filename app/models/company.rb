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

class Company < ActiveRecord::Base
  has_many :people, :dependent => :destroy
  has_many :groups, :dependent => :destroy
  has_many :users, :through => :people, :source => :user
  
  with_options :class_name => "Person" do |people|
    people.has_many :employees, :conditions => {:is_employee => true}
    people.has_many :clients, :conditions => {:is_employee => false}
  end
  
  validates_presence_of :name
  validates_presence_of :permalink
  validates_length_of :name, :within => 3..40
  validates_length_of :permalink, :within => 3..16
  
  #Group
  
  def create_group!(user, group) 
    self.groups.create(group) do |g|
      g.user = user
    end
  end
  
  
  #User
  
  def add_employee!(user)
    unless has_employee?(user) || user.company
      person = Person.where(:company_id => id, :user_id => user.id).first
      person ||= people.build
      person.is_employee = true
      person.user = user
      person.save
      person
    end
  end
  
  def add_client!(user)
    unless has_client?(user) || has_employee?(user)
      people.create do |person|
        person.user = user
        person.is_employee  = false
      end
    end
  end
  
  def remove_person!(user)
    people.find_by_user_id(user.id).try(:destroy)
  end
  
  def has_person?(user)
    people.exists?(:user_id => user.id)
  end
  
  def has_employee?(user)
    employees.exists?(:user_id => user.id)
  end
  
  def has_client?(user)
    clients.exists?(:user_id => user.id)
  end
  
  def admin?(user)
    people.exists?(:user_id => user.id, :is_admin => true)
  end

  def log_activity(target, action, user = nil)
    user ||= target.try(:user)
    Activity.log(self, target, action, user)
  end   
end
