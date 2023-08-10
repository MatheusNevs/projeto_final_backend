# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

obj = User.create!(name: "joao", last_name: 'da silva', email:'joao123@gmail.com', password:'123456', is_admin: true)
obj.profile_picture.attach(io: File.open('./public/istockphoto-1040315976-612x612.jpg'), filename: 'istockphoto-1040315976-612x612.jpg')