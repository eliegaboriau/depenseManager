# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create users
4.times do
  User.create!(
    email: Faker::Internet.email,
    password: 'password' # Change this to the desired password
  )
  puts "User created with email: #{User.last.email} and password: password"
end

User.create!(
  email: 'admin@example.org',
  password: 'decidim123456',
)
puts "User created with email: #{User.last.email} and password: decidim123456"

# Create categories for each user
User.all.each do |user|
  3.times do
    Category.create!(
      name: Faker::Lorem.word,
      user: user
    )
  end
  puts "Categories created for user #{user.email} with names: #{Category.where(user: user).pluck(:name).join(', ')}"
end

# Create expenses for each user and associate them with a random category
User.all.each do |user|
  10.times do
    Depense.create!(
      amount: Faker::Number.between(from: 10, to: 1000),
      category: Category.where(user: user).sample,
      date: Faker::Date.between(from: 1.month.ago, to: Date.today),
      user: user
    )
  end
  puts "Depenses created for user #{user.email}"
end
