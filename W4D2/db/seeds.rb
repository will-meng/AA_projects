# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


cat1 = Cat.create!(name: Faker::Name.name, birth_date: Faker::Date.birthday(1,15), sex: "F", color: "black")
cat2 = Cat.create!(name: Faker::Name.name, birth_date: Faker::Date.birthday(1,15), sex: "M", color: "black")
cat3 = Cat.create!(name: Faker::Name.name, birth_date: Faker::Date.birthday(1,15), sex: "F", color: "black")
cat4 = Cat.create!(name: Faker::Name.name, birth_date: Faker::Date.birthday(1,15), sex: "M", color: "black")
cat5 = Cat.create!(name: Faker::Name.name, birth_date: Faker::Date.birthday(1,15), sex: "F", color: "black")
