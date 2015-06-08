# Subclass for Game for the Rock Paper Scissors Lizard Spock variation of the game
#
# If the RPSLS version of the game is picked, this will be the Game object initialized instead of the regular one.
#
# This subclass takes all of the same arguments as the superclass, player_one_name, player_two_name, and best_of, and sets
# the same attributes, @rounds_to_win, @player_one, and @player_two, as well as a new @allowed_moves attribute, to account
# for the increased move set for this version.
require_relative "game"
class RPSLSGame < Game
  
  attr_reader :rounds_to_win, :allowed_moves
  attr_accessor :player_one, :player_two 
  # Our initialize method.  There are three arguments for each instance of this class, player_one_name, player_two_name and best_of. 
  #
  # There are 4 attributes for each instance:
  # => @rounds_to_win - an integer for the number of rounds each player must win to win each instance of the game
  # => @player_one - a Player object we create using the player_one_name argument.
  # => @player_two - a Player object we create using the player_two_name argument.
  # => @allowed_moves - an array of the allowed moveset for each instance of this object
  def initialize(player_one, player_two, best_of)
    @rounds_to_win = ((best_of / 2.0).floor) + 1
    @player_one = player_one
    @player_two = player_two
    @allowed_moves = %w(spock lizard rock paper scissors)
  # def initialize(player_one_name, player_two_name, best_of)
  #   @rounds_to_win = ((best_of / 2.0).floor) + 1
  #   @player_one = Player.new(player_one_name)
  #   @player_two = Player.new(player_two_name)
  #   @allowed_moves = %w(spock lizard rock paper scissors)
  end
  # New method for the subclass RPSLSGame.  It follows the same logic behind the first set, however also allows for the
  # two new moves in our game, and the logic for it.
  #
  # This method has no arguments, still relying on all previous collected input
  #
  # This method returns
  def round
    if @allowed_moves.index(@player_one.move) == @allowed_moves.index(@player_two.move)
      tie_round
    elsif (@allowed_moves.index(@player_one.move) - 1) == @allowed_moves.index(@player_two.move)
      @player_one.win_round
      player_one_win_speech
    elsif @allowed_moves.index(@player_one.move) == 0 && @allowed_moves.index(@player_two.move) == 4
      @player_one.win_round
      player_one_win_speech
    elsif (@allowed_moves.index(@player_one.move) + 2) == @allowed_moves.index(@player_two.move)
      @player_one.win_round
      player_one_win_speech
    elsif @allowed_moves.index(@player_one.move) == 3 && @allowed_moves.index(@player_two.move) == 0
      @player_one.win_round
      player_one_win_speech
    elsif @allowed_moves.index(@player_one.move) == 4 && @allowed_moves.index(@player_two.move) == 1
      @player_one.win_round
      player_one_win_speech
    else
      @player_two.win_round
      player_two_win_speech
    end
    show_score
  end
 
end

