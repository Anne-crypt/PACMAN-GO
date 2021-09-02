# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Cleaning database...(Players, Games, Participations"
Game.destroy_all
puts "Games cleaned"
puts " "
puts " "
Player.destroy_all
puts "Players cleaned"
puts " "
puts " "
Participation.destroy_all
puts "Participation cleaned"
puts " "
puts " "

puts "Creating players..."
  seeded_players = []
  anne = Player.new(nickname: "Anne", latitude: "48.865171", longitude: "2.379983")
  raph = Player.new(nickname: "Rapkalin", latitude: "48.865587", longitude: "2.379623")
  dorien = Player.new(nickname: "Dodo", latitude: "48.865933", longitude: "2.379347")
  rahim = Player.new(nickname: "Rahim", latitude: "48.865588", longitude: "2.380347")
  # sunny = Player.new(nickname: "Sunny", latitude: "48.864959", longitude: "2.379320")
  players = [anne, raph, dorien, rahim]
  players.each do |player|
    player.save!
    seeded_players << player
    puts "#{player.nickname} has been created"
  end
  puts "You have created #{players.count} players"

puts " "
puts " "

puts "Creating Game..."
  game = Game.new(token: "WAGON", lives: 4, player_id: anne.id)
  game.save!
  puts "A game has been created: "
  puts "Token: WAGON"
  puts "Game id is: #{game.id}"
  puts "Host: Anne - id: #{anne.id}"

puts " "
puts " "

puts "Creating Participation"

  puts "A participation has been created for the following players:"
  players.each do |player|
      participation = Participation.new(game_id: game.id, player_id: player.id, role: "ghost")
      participation.save!
  end

Participation.last.update!(role: "pacman")

  Participation.all.each do |participation|
    puts "#{participation.player.nickname} - id: #{participation.player.id} - role: #{participation.role}"
  end

puts " "
puts " "

puts "You are good to go! :)"
