# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Initialize category
    Category.create!(name: "Technology")

    Category.create!(name: "Product")

    Category.create!(name: "Design")

    Category.create!(name: "Operation")

    Category.create!(name: "Marketing")

    Category.create!(name: "Sales")

    Location.create!(name: "Taipei")

    Location.create!(name: "New Taipei")

    Location.create!(name: "Taoyuan")

    Location.create!(name: "Hsinchu")

    Location.create!(name: "Taichung")

    Location.create!(name: "Tainan")

    Location.create!(name: "Kaohsiung")

    Location.create!(name: "Ａbroad")
