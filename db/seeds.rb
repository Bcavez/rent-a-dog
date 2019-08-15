# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'

puts "Destroying existing users :"
User.destroy_all


puts "Creatings users ..."

10.times do
  # create a fake user
  p faker_user = User.new(
    name: Faker::Superhero.prefix,
    lastname: Faker::Superhero.name,
    address: Faker::Movies::LordOfTheRings.location,
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 8),
    payment: false,
    # Replace later with CLOUDINARY STUFF
    # photo: "https://picsum.photos/200"
    )
  # create a fake dog

  p faker_dog = Dog.new(
    name: Faker::Movies::Hobbit.character,
    race: Faker::Creature::Dog.breed,
    size: ['small', 'medium', 'large'].sample,
    description: Faker::Creature::Dog.meme_phrase,
    )

  url = "https://res.cloudinary.com/dx8gouewf/image/upload/v1565798934/pdw0qkmuurnlrmq9cyx2.jpg"
  user_placeholder_url = "https://res.cloudinary.com/dx8gouewf/image/upload/v1565798933/cv1ksi2n9o5uxqkqjedx.jpg"
  # link the dog to its user
  faker_dog.user = faker_user
  faker_user.photo = open(user_placeholder_url)
  faker_dog.photo = open(url)
  # save to databse
  faker_dog.save!
  faker_user.save!
end

puts "Done creating users & dogs with reviews ! Congrats"
# create 30 random bookings

puts "Creating bookings and reviews..."
30.times do
  p faker_booking = Booking.new(description: Faker::GreekPhilosophers.quote, date: Faker::Date.forward(days: 23), payed: false, confirmed: false)
  p faker_review = Review.new(
    description: Faker::Movies::VForVendetta.quote,
    rating: rand(0..5),
  )
  # assign booking and review to a random user
  random_user = User.order("RANDOM()").first
  faker_booking.user = random_user
  faker_review.user = random_user
  # assign booking to a random dog
  random_dog = Dog.order("RANDOM()").first
  faker_booking.dog = random_dog
  faker_review.dog = random_dog

  #save the booking
  faker_booking.save!
  #save the review
  faker_review.save!
end

puts "Done creating bookings and reviews !"

puts "Creating admin ..."

admin = User.new(
  name: "Admin",
  lastname: "TheAdmin",
  address: "adminaddress",
  email: "admin@admin.com",
  password: "administrator",
  payment: false,
  admin: true,
  )

puts "Done creating admin !"

puts "creating test user"

p dadou = User.new(
  name: "Dadou",
  lastname: "des Bois",
  address: Faker::Movies::LordOfTheRings.location,
  email: "dadou@desbois.com",
  password: "dadoudesbois",
  payment: false,
)

p dog1 = Dog.new(
  name: Faker::Movies::Hobbit.character,
  race: Faker::Creature::Dog.breed,
  size: ['small', 'medium', 'large'].sample,
  description: Faker::Creature::Dog.meme_phrase,
  )

p dog2 = Dog.new(
  name: Faker::Movies::Hobbit.character,
  race: Faker::Creature::Dog.breed,
  size: ['small', 'medium', 'large'].sample,
  description: Faker::Creature::Dog.meme_phrase,
  )

# seed some of dadou's bookings
3.times do
  p dadou_booking = Booking.new(description: Faker::GreekPhilosophers.quote, date: Faker::Date.forward(days: 23), payed: false, confirmed: false)
  p dadou_review = Review.new(
    description: Faker::Movies::VForVendetta.quote,
    rating: rand(0..5),
  )
  dadou_booking.user = dadou
  dadou_review.user = dadou
  # assign booking to a random dog
  random_dog = Dog.order("RANDOM()").first
  dadou_booking.dog = random_dog
  dadou_review.dog = random_dog

  #save the booking
  dadou_booking.save!
  #save the review
  dadou_review.save!
end

# add some reviews to dadou's dogs

3.times do
  p fake_review = Review.new(
    description: Faker::Movies::VForVendetta.quote,
    rating: rand(0..5),
  )
  fake_review.dog = dog1
  # assign review to a random user
  random_user = User.order("RANDOM()").first
  fake_review.user = random_user
  fake_review.save!
end

3.times do
  p fake_review = Review.new(
    description: Faker::Movies::VForVendetta.quote,
    rating: rand(0..5),
  )
  fake_review.dog = dog2
  # assign review to a random user
  random_user = User.order("RANDOM()").first
  fake_review.user = random_user
  fake_review.save!
end

url = "https://res.cloudinary.com/dx8gouewf/image/upload/v1565798934/pdw0qkmuurnlrmq9cyx2.jpg"
user_placeholder_url = "https://res.cloudinary.com/dx8gouewf/image/upload/v1565798933/cv1ksi2n9o5uxqkqjedx.jpg"
dog1.user = dadou
dog2.user = dadou
dadou.photo = open(user_placeholder_url)
dog1.photo = open(url)
dog2.photo = open(url)
dog1.save!
dog2.save!
dadou.save!


puts "Done creating test user !"

admin.photo = open("https://res.cloudinary.com/dx8gouewf/image/upload/v1565798930/xwecm1a8xs9tunarokjj.jpg")
admin.save!
