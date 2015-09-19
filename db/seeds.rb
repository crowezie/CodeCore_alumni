# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


skills_array = ["Ruby", "HTML", "CSS", "Javascript", "Bootstrap"];

# generates 100 users, with corresponding profiles and skills
100.times do
  user =
  User.create(
    first_name:      Faker::Name.first_name,
    last_name:       Faker::Name.last_name,
    email:           Faker::Internet.email,
    password_digest: BCrypt::Password.create("password")
  )
  user.profile = Profile.create(
    description:  Faker::Lorem.paragraph,
    availability: true,
    pitch:        Faker::Lorem.sentences(1),
    image:        Faker::Avatar.image,
    phone:        Faker::PhoneNumber.phone_number,
    email:        Faker::Internet.email,
    location:     Faker::Address.city
  )
  # get random number of skills from skills array
  userskills = skills_array.sample(rand(1...skills_array.length))
  # for each skill generated, add it to a user profile
  userskills.each do |x|
    user.profile.skills.create(name: x, level: rand(0...10))
  end
  

end