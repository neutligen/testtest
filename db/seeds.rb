# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(email: email,
               password:              password,
               password_confirmation: password,
               activated:true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  title = Faker::Lorem.sentence(5)
  users.each { |user| user.to_do_lists.create!(title: title, priority_flg: "lite", category_id: user.id ) }
end

# カテゴリ

Category.create!(category_name: "宿題", user_id: 1 )
Category.create!(category_name: "マラソン", user_id: 1 )
Category.create!(category_name: "筋トレ", user_id: 1 )
Category.create!(category_name: "執筆", user_id: 1 )
Category.create!(category_name: "早起き", user_id: 1 )

6.times do |n|
  category_name = "#{n}stuff"
  user_id = n
  Category.create!( category_name: category_name, user_id: user_id )
end
