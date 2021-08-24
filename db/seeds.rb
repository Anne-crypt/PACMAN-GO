# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Cleaning database...(Players, Games, Participations"
Game.destroy_all
Player.destroy_all
Participation.destroy_all

puts " "
puts " "

puts "Creating players..."
  anne = Player.new(nickname: "Anne")
  raph = Player.new(nickname: "Rapkalin")
  dorien = Player.new(nickname: "Dodo")
  rahim = Player.new(nickname: "Rahim")
  sunny = Player.new(nickname: "Sunny")
  players = [anne, raph, dorien, rahim, sunny]
  players.each do |player|
    player.save!
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
  puts "Host: Anne - id: #{anne.id}"

puts " "
puts " "

puts "Creating Participation"

  puts "A participation has been created for the following players:"
  players.each do |player|
      participation = Participation.new(game_id: game.id, players_id: player.id, role: "ghost")
      participation.save!
  end

Participation.last.update!(role: "pacman")

  players.each do |player|
    puts "#{player.nickname} - id: #{player.id} - role: #{player.role}"
  end

puts " "
puts " "

puts "You are good to go! :)"
