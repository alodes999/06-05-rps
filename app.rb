# Rock Paper Scissors
#
# App.rb
require_relative 'gamedriver'
require_relative 'refactoredgame'
require_relative 'player'
require_relative 'rpslsgame'
# creates our new GameDriver instance
gd1 = GameDriver.new
# collects our data for our GameDriver to pass to our other Game objects
gd1.set_player_one
gd1.set_player_two
gd1.choose_game
gd1.rounds
# runs the correct game object based on our input
gd1.start_game
binding.pry

gd1.run_round

# asks if there are more games to play, looping and adding score for games won.
puts "Would you like to play another game?"
choice = gets.chomp.downcase

while choice == "yes"
  gd1.choose_game
  gd1.rounds
  
  gd1.start_game
  gd1.run_round
  
  puts "Would you like to play another game?"
  choice = gets.chomp.downcase
end