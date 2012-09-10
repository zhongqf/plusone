require 'factory_girl'
require 'faker'

FactoryGirl.define do

  sequence :email do |n|
    name = "#{Faker::Name.first_name} #{Faker::Name.last_name}"
    username = Faker::Internet.user_name(name)
    domain = Faker::Internet.domain_name

    "#{username}#{n}@#{domain}"
  end
  
  sequence :identity do |n|
    "id#{'%06d' % n}"
  end

  sequence :name  do |n|
    "#{Faker::Name.first_name} #{Faker::Name.last_name}"
  end

  sequence :permalink do |n|
    "#{Faker::Lorem.words} #{n}".parameterize("_")
  end
  
  sequence :title do |n|
    Faker::Lorem.sentence
  end

  sequence :text do |n|
    Faker::Lorem.paragraph
  end
  
end