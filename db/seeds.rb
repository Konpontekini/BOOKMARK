# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# require "open-uri"

puts "Cleaning database..."
Item.destroy_all
User.destroy_all
Category.destroy_all

puts "Creating user..."
user = User.create!(
    first_name: 'fang',
    last_name: 'zhao',
    email: 'bookmark@hotmail.com',
    password: 'password'
  )

puts "user created!"

puts "Creating categories..."


list_array = ["homeware", "beauty", "gifts", "music", "sports", "gardening", "electricals", "clothing", "makeups", "footwear", "fitness", "travel", "accessories", "books", "pets"]
list_array.each do |category|
  category = Category.new(name: category)
  category.save!
end


puts "Creating items..."

curtain = { user: User.last, name: "Velvet Curtain, 36 colors, Rod pocket Luxury Velvet Curtain, Curtain Panel,Blackout velvet curtain,Curtains for Living Room and Bedroom", description: "nice curtain for bedrooms", currency: "£", price: 17, purchased: false, category: Category.first, item_url: "https://www.etsy.com/uk/listing/1005168066/velvet-curtain-36-colors-rod-pocket?ga_order=most_relevant&ga_search_type=all&ga_view_type=gallery&ga_search_query=curtain&ref=sc_gallery-1-1&pro=1&frs=1&listing_id=1005168066&listing_slug=velvet-curtain-36-colors-rod-pocket&plkey=46100b82c0725d257bedd3dfa7bed4846ef6bdc4%3A1005168066",
  image_url: ["https://i.etsystatic.com/20098313/r/il/9f421a/3264855092/il_1588xN.3264855092_rurc.jpg", "https://i.etsystatic.com/20098313/r/il/4c41c8/3534855060/il_794xN.3534855060_gvv1.jpg", "https://i.etsystatic.com/20098313/r/il/1e6a55/3311439541/il_794xN.3311439541_cpij.jpg"] }
bed = { user: User.last, name: "Nodax Wooden Solid Pine Bed Frame Model F1 in oak finish", description: "comfortable bed", currency: "£", price: 219, purchased: false, category: Category.first, item_url: "https://www.etsy.com/uk/listing/710794101/nodax-wooden-solid-pine-bed-frame-model?click_key=9b9afdd738e76770371d2e75902cfe64ed9d4951%3A710794101&click_sum=a358167d&ga_order=most_relevant&ga_search_type=all&ga_view_type=gallery&ga_search_query=bed&ref=sr_gallery-1-1&organic_search_click=1&frs=1&bes=1",
  image_url: ["https://i.etsystatic.com/20288125/r/il/bfc5a6/1896653412/il_794xN.1896653412_4p98.jpg"] }
shoe = { user: User.last, name: "Daisy Embroidered Felt Slippers - Lucky Dip", description: "fashionable boots", category: Category.last, currency: "£", price: 25, purchased: false, item_url: "https://www.etsy.com/uk/listing/789882612/daisy-embroidered-felt-slippers-lucky?ga_order=most_relevant&ga_search_type=all&ga_view_type=gallery&ga_search_query=shoes&ref=sc_gallery-1-3&pro=1&frs=1&listing_id=789882612&listing_slug=daisy-embroidered-felt-slippers-lucky&plkey=e49ab71dd364955028ff9f47e48d8e1578746a8b%3A789882612",
  image_url: ["https://i.etsystatic.com/17066802/r/il/776aad/2343561423/il_1588xN.2343561423_ku3j.jpg", "https://i.etsystatic.com/17066802/r/il/49f0a6/2490131508/il_794xN.2490131508_m8tg.jpg", "https://i.etsystatic.com/17066802/r/il/f29251/2468899764/il_794xN.2468899764_o1ou.jpg"] }
dress = { user: User.last, name: "VINCE | Satin slip skirt", description: "Vince - Satin slip skirt", category: Category.last, currency: "£", price: 315, purchased: false, item_url: "https://www.mytheresa.com/en-de/vince-satin-slip-skirt-2156819.html?catref=category",
  image_url: ["https://img.mytheresa.com/1088/1088/66/jpeg/catalog/product/2d/P00660556.jpg", "https://img.mytheresa.com/1088/1088/66/jpeg/catalog/product/2d/P00660556_b1.jpg", "https://img.mytheresa.com/1088/1088/66/jpeg/catalog/product/2d/P00660556_b2.jpg"] }


[ curtain, bed, shoe, dress ].each do |attributes|
  item = Item.create!(attributes)
  puts "Created #{item.name}"
end

puts "Finished!"
