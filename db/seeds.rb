# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
italian = Category.where(name: "Italian").first_or_create(name: "Italian")
chinese = Category.where(name: "chinese").first_or_create(name: "chinese")
mexican = Category.where(name: "mexican").first_or_create(name: "mexican")
french = Category.where(name: "french").first_or_create(name: "french")
greek = Category.where(name: "greek").first_or_create(name: "greek")
indian = Category.where(name: "indian").first_or_create(name: "indian")
japanese = Category.where(name: "japanese").first_or_create(name: "japanese")
american = Category.where(name: "american").first_or_create(name: "american")

Restaurant.where(name: "Taco Bell").first_or_create(name: "Taco Bell", descripton: "tacos", city: "saint paul", state: "mn", category_id: mexican.id)
Restaurant.where(name: "Burrito").first_or_create(name: "Burrito", descripton: "Burrito", city: "Brooklyn", state: "NY", category_id: mexican.id)
Restaurant.where(name: "chipotle").first_or_create(name: "chipotle", descripton: "chipotle", city: "manhattan", state: "NY", category_id: mexican.id)
Restaurant.where(name: "Taco jon's").first_or_create(name: "Taco Jon's", descripton: "tacos", city: "jersey city", state: "NJ", category_id: mexican.id)

Restaurant.where(name: "McDonals").first_or_create(name: "McDonals", descripton: "McDonals", city: "saint paul", state: "mn", category_id: american.id)
Restaurant.where(name: "Burger King").first_or_create(name: "Burger King", descripton: "Burger King", city: "Brooklyn", state: "NY", category_id: american.id)
Restaurant.where(name: "wendys").first_or_create(name: "wendys", descripton: "wendys", city: "manhattan", state: "NY", category_id: american.id)
Restaurant.where(name: "shake shack").first_or_create(name: "shake shack", descripton: "shake shack", city: "jersey city", state: "NJ", category_id: american.id)
