# Rock Paper Scissors
#
# App.rb
require_relative 'gamedriver'
# creates our new GameDriver instance
game = GameDriver.new
# collects our data for our GameDriver to pass to our other Game objects
game.set_player_one
game.set_player_two
game.choose_game
game.rounds
# runs the correct game object based on our input
game.start_game
# asks if there are more games to play, looping and adding score for games won.
puts "Would you like to play another game?"
choice = gets.chomp.downcase

while choice == "yes"
  game.choose_game
  game.rounds
  
  game.start_game
  
  puts "Would you like to play another game?"
  choice = gets.chomp.downcase
end