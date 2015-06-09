# This contains the Game class for our RPS program.
class Game

  attr_reader :rounds_to_win, :allowed_moves
  attr_accessor :player_one, :player_two 
  # Our initialize method.  There are three arguments for each instance of this class, player_one, player_two and best_of. 
  #
  # There are 4 attributes for each instance:
  # => @rounds_to_win - an integer for the number of rounds each player must win to win each instance of the game
  # => @player_one - a Player object we pass from our GameDriver class.
  # => @player_two - a Player object we pass from our GameDriver class.
  # => @allowed_moves - an array of the allowed moveset for each instance of this object
  def initialize(player_one, player_two, best_of)
    @rounds_to_win = ((best_of / 2.0).floor) + 1
    @player_one = player_one
    @player_two = player_two
    @allowed_moves = %w(rock paper scissors)
  end
  # This method checks to see if a move is a legal move.  It checks the passed parameter against the MOVES array.
  #
  # This accepts one argument, a string from where the method is passed.
  #
  # This returns either true or false, depending on whether the string is in the MOVES array.
  def check_move(move_to_check)
    @allowed_moves.include?(move_to_check.downcase)
  end
  # This method is our round.  It takes each player's move and checks it against our list of allowable moves. Whichever player wins,
  # it will increment their score and call the correct output text for that outcome. 
  #
  # This method takes no arguments, only reading already set attributes
  #
  # This method doesn't explicitly return anything, and implicitly returns nil
  def round
    if @allowed_moves.index(@player_one.move) == @allowed_moves.index(@player_two.move)
      0
    elsif (@allowed_moves.index(@player_one.move) - 1) == @allowed_moves.index(@player_two.move)
      1
    elsif @allowed_moves.index(@player_one.move) == 0 && @allowed_moves.index(@player_two.move) == 2
      1
    else
      2
    end
  end
end