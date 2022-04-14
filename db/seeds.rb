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

    u = User.new
    u.email = "123@qwe.com"           # 可以改成自己的 email

    u.password = "123qwe"                # 最少要六码

    u.password_confirmation = "123qwe"   # 最少要六码

    u.is_admin = true
    u.save
