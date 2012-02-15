require 'factory_girl'

FactoryGirl.define do
  
  sequence :email do |n| 
    "mail#{n}@mailserver.com"
  end
  
  sequence :identity do |n|
    "identity_#{n}"
  end

  sequence :name  do |n|
    "Name ##{n}"
  end

  sequence :permalink do |n|
    "permalink_#{n}"
  end
  
  sequence :text do |n|
    "Text content #{n}"
  end
  
end