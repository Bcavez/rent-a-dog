# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  # create a fake user
  faker_user = User.new(
    name: Faker::Superhero.prefix,
    lastname: Faker::Superhero.name,
    address: Faker::Movies::LordOfTheRings.location,
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 8),
    payment: false,
    photo: "https://picsum.photos/200"
    )
  # create a fake dog
  faker_dog = Dog.new(
    name: Faker::Movies::Hobbit.character,
    race: Faker::Creature::Dog.breed,
    size: ['small', 'medium', 'large'].sample,
    description: Faker::Creature::Dog.meme_phrase,
    )

  url = "https://source.unsplash.com/random"
  # link the dog to its user
  faker_dog.user = faker_user
  faker_dog.remote_photo_url = url
  # save to databse
  faker_user.save!
  faker_dog.save!
end

# create 30 random bookings
30.times do
  faker_booking = Booking.new(description: Faker::GreekPhilosophers.quote, date: Faker::Date.forward(days: 23), payed: false, confirmed: false)
  # assign booking to a random user
  faker_booking.user = User.order("RANDOM()").first
  # assign booking to a random dog
  faker_booking.dog = Dog.order("RANDOM()").first

  #save the booking
  faker_booking.save!
end
