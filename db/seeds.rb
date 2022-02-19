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

puts "Creating user..."
user = User.create!(
    first_name: 'fang',
    last_name: 'zhao',
    email: 'fangzhao021@hotmail.com',
    password: '11111111'
  )

puts "user created!"

puts "Creating items..."
curtain = { user: User.last, name: "net curtain", description: "nice curtain for bedrooms", price: 86.00, purchased: false, category: "home", item_url: "https://www.johnlewis.com/gp-j-baker-poppy-paisley-made-to-measure-curtains-or-roman-blind-ochre/p5660062" }
bed = { user: User.last, name: "bed", description: "comfortable bed", price: 729.00, purchased: false, category: "home", item_url: "https://www.johnlewis.com/john-lewis-partners-rattan-bed-frame-king-size/p4147243" }
# shoe = { user: User.last, category: "fashion", item_url: "https://www.farfetch.com/uk/shopping/women/prada-logo-plaque-detail-panelled-boots-item-16762068.aspx?storeid=11240" }
shoe = { user: User.last, name: "boot", description: "fashionable boots", category: "fashion", price: 1100.00, purchased: false, item_url: "https://www.farfetch.com/uk/shopping/women/prada-logo-plaque-detail-panelled-boots-item-16762068.aspx?storeid=11240" }

[ curtain, bed, shoe ].each do |attributes|
  item = Item.create!(attributes)
  puts "Created #{item.name}"
end

puts "Finished!"
