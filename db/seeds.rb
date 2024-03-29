# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create(
#      [
#        { name: 'Star Wars' },
#        { name: 'Lord of the Rings' }
#      ]
#    )
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

wileys = Restaurant.new
wileys.name = "Wiley's BBQ"
wileys.location = "Highway 80"
wileys.save!

kakki = Restaurant.new
kakki.name = "Kakki's"
kakki.location = "Highway 80"
kakki.save!

jthomas = Restaurant.new
jthomas.name = "JThomas"
jthomas.location = "Highway 80"
jthomas.save!

miyabi = Restaurant.new
miyabi.name = "Miyabi's"
miyabi.location = "Eisenhower Dr"
miyabi.save!

basil = Restaurant.new
basil.name = "Basil's"
basil.location = "Johnny Mercer Blvd"
basil.save!

papamurphy = Restaurant.new
papamurphy.name = "Papa Murphy's"
papamurphy.location = "Johnny Mercer Blvd"
papamurphy.save!

paula = Restaurant.new
paula.name = "The Lady & Sons"
paula.location = "W Congress St"
paula.save!

seafood = Restaurant.new
seafood.name = "Creek House Seafood & Grill"
seafood.location = "Bryan Woods Rd"
seafood.save!

curry = Restaurant.new
curry.name = "Himalayan Curry Kitchen"
curry.location = "Ford Ave"
curry.save!

sakura = Restaurant.new
sakura.name = "Sakura Buffet"
sakura.location = "Eisenhower Dr"
sakura.save!

soup = Restaurant.new
soup.name = "Wattana Panic"
soup.location = "Bangkok"
soup.save!

harris = Restaurant.new
harris.name = "Johnny Harris"
harris.location = "East Victory Dr"
harris.save!

vinnie = Restaurant.new
vinnie.name = "Vinnie Van Go-Go's"
vinnie.location = "W Bryan St"
vinnie.save!

pie = Restaurant.new
pie.name = "Pie Society"
pie.location = "Jefferson St"
pie.save!

85.times do
  Restaurant.create!(
    name: Faker::Restaurant.name,
    location: Faker::Address.unique.full_address
  )
end

user_one = User.new
user_one.email = 'test@example.com'
user_one.password = 'testing'
user_one.password_confirmation = 'testing'
user_one.save!

user_two = User.new
user_two.email = 'example@example.com'
user_two.password = 'roflol'
user_two.password_confirmation = 'roflol'
user_two.save!

user_admin = User.new
user_admin.email = 'jmurrel1@my.westga.edu'
user_admin.password = 'leaked'
user_admin.password_confirmation = 'leaked'
user_admin.save!

Vote.create!(
  split: true,
  restaurant_id: wileys.id,
  user_id: user_admin.id
)

584.times do
  Vote.create!(
    split: true,
    restaurant_id: Faker::Number.within(range: 1..99),
    user_id: Faker::Number.within(range: 1..3)
  )
end

479.times do
  Vote.create!(
    split: false,
    restaurant_id: Faker::Number.within(range: 1..99),
    user_id: Faker::Number.within(range: 1..3)
  )
end

25.times do
  Favorite.create!(
    restaurant_id: Faker::Number.within(range: 1..99),
    user_id: Faker::Number.within(range: 1..3)
  )
end

174.times do
  Comment.create!(
    restaurant_id: Faker::Number.within(range: 1..99),
    user_id: Faker::Number.within(range: 1..3),
    comment: Faker::Lorem.paragraph
  )
end

30.times do
  Comment.create!(
    restaurant_id: Faker::Number.within(range: 1..99),
    user_id: Faker::Number.within(range: 1..3),
    comment: Faker::ChuckNorris.fact
  )
end

8.times do
  Comment.create!(
    restaurant_id: Faker::Number.within(range: 1..99),
    user_id: Faker::Number.within(range: 1..3),
    comment: Faker::Quotes::Shakespeare.hamlet_quote
  )
end

7.times do
  Comment.create!(
    restaurant_id: Faker::Number.within(range: 1..99),
    user_id: Faker::Number.within(range: 1..3),
    comment: Faker::Quote.yoda
  )
end

8.times do
  Comment.create!(
    restaurant_id: Faker::Number.within(range: 1..99),
    user_id: Faker::Number.within(range: 1..3),
    comment: Faker::Quote.famous_last_words
  )
end

7.times do
  Comment.create!(
    restaurant_id: Faker::Number.within(range: 1..99),
    user_id: Faker::Number.within(range: 1..3),
    comment: Faker::Quotes::Shakespeare.romeo_and_juliet_quote
  )
end

=begin
  43.times do
    User.create!(
      email: Faker::Internet.unique.email,
      encrypted_password: Faker::Internet.password(min_length: 6)
    )
  end
=end
