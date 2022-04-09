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

#vote_admin_wileys = Vote.new
#vote_admin_wileys.split = true
#vote_admin_wileys.restaurant_id = wileys.id
#vote_admin_wileys.user_id = user_admin.id
#vote_admin_wileys.save!

Vote.create!(
  split: true,
  restaurant_id: wileys.id,
  user_id: user_admin.id
)

=begin
  43.times do
    User.create!(
      email: Faker::Internet.unique.email,
      encrypted_password: Faker::Internet.password(min_length: 6)
    )
  end
=end
