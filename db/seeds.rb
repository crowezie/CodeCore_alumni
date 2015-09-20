# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


skills_array = ["Ruby", "HTML", "CSS", "Javascript", "Bootstrap"];

# generates 100 users, with corresponding profiles, skills, projects, educations
100.times do

  # 50% change of user being approved or not
  chance = rand(2)
  if chance ==0
    approved_value = false
  else
    approved_value = true
  end 

  user =
  User.create(
    first_name:      Faker::Name.first_name,
    last_name:       Faker::Name.last_name,
    email:           Faker::Internet.email,
    password:        "supersecret",
    approved:        approved_value
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

  # create x number of projects for each profile
  (1..(rand(2..10))).each do |project|
    user.profile.projects.create(
      title: Faker::Company.catch_phrase,
      description: Faker::Lorem.paragraph,
      logo_project: Faker::Avatar.image,
      weblink: Faker::Internet.url('example.com'),
      sourcecode: Faker::Internet.url('example.com')
      )
  end


  # create x number of educations for each profile


  (1..(rand(2..5))).each do |education|

    year_from = rand(1900...Date.today.strftime("%Y").to_i)
    year_to   = year_from+rand(1...10)

    user.profile.educations.create(
      school_name:     Faker::Company.name,
      year_from:       year_from,
      year_to:         year_to,  
      degree:          Faker::Commerce.department,
      logo_education:  Faker::Avatar.image
      )
  end



  # create x number of experiences for each profile

  (1..(rand(2..5))).each do |experience|

    user.profile.experiences.create(
      position:         Faker::Name.title,
      company:          Faker::Company.name,
      description:      Faker::Lorem.paragraph,  
      weblink:          Faker::Internet.url,
      logo_experience:  Faker::Avatar.image
      )
  end

end


  # Create one admin user
  User.create(
    first_name:      "Codecore",
    last_name:       "Admin",
    email:           "codecore@codecore.com",
    password:        "supersecret",
    admin:           true
  )



