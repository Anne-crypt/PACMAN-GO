# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "..."
puts "Cleaning database..."
Player.destroy_all

puts "..."
puts "Creating players..."
anne = Player.new(nickname: "Anne", color: "blue")
raph = Player.new(nickname: "Rapkalin", color: "red")
dorien = Player.new(nickname: "Dodo", color: "pink")
rahim = Player.new(nickname: "Rahim", color: "Orange")

players = [anne, raph, dorien, rahim]

players.each do |player|
  player.save!
  puts "#{player.nickname} has been created"
end

puts "You have created #{players.count} players"
puts "..."
puts "You are good to go! :)"
