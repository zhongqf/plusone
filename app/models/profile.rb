# == Schema Information
#
# Table name: profiles
#
#  id                  :integer(4)      not null, primary key
#  user_id             :integer(4)
#  email               :string(255)
#  first_name          :string(255)
#  last_name           :string(255)
#  name                :string(255)
#  bio                 :text
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer(4)
#  avatar_updated_at   :datetime
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#

class Profile < ActiveRecord::Base
  concerned_with  :avatar
  attr_accessible :bio, :first_name, :last_name

  belongs_to :user

  has_many :contact_items, :order => [:category, :created_at]
  accepts_nested_attributes_for :contact_items, :reject_if => proc { |attrs| attrs['value'].blank? }, :allow_destroy => true
  attr_accessible :contact_items_attributes

end
