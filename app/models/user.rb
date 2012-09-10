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

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_one :profile
  accepts_nested_attributes_for :profile
  attr_accessible :profile_attributes
  
  has_many :members
  has_many :groups, :through => :members, :source => :group

  belongs_to :organization_group, :class_name => "Group"
  
  before_create :find_or_create_profile
  
  
  protected
    def find_or_create_profile
      unless self.profile
        self.profile = Profile.find_or_create_by_email(self.email)
        self.profile.save
      end
    end

end
