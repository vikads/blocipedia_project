# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

#Create Users
10.times do
  User.create!(
    email: Faker::Internet.safe_email,
    password: Faker::Internet.password,
    confirmed_at: Time.now
  )
end
users = User.all

#Create Wikis
20.times do
  Wiki.create!(
    user: users.sample,
    title: Faker::Community.characters,
    body: Faker::Community.quotes,
    private: false
  )
end
wikis = Wiki.all

# Create standard user
standard = User.create!(
  email: 'standard@example.com',
  password: 'password',
  confirmed_at: Time.now,
  role: 'standard'
)

# Create premium user
premium = User.create!(
  email: 'premium@example.com',
  password: 'password',
  confirmed_at: Time.now,
  role: 'premium'
)

# Create admin user
admin = User.create!(
  email: 'admin@example.com',
  password: 'password',
  confirmed_at: Time.now,
  role: 'admin'
)

puts "Seed finished"
puts "#{User.count} users created."
puts "#{Wiki.count} wikis created."
