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
      tie_round
    elsif (@allowed_moves.index(@player_one.move) - 1) == @allowed_moves.index(@player_two.move)
      player_one_win
    elsif @allowed_moves.index(@player_one.move) == 0 && @allowed_moves.index(@player_two.move) == 2
      player_one_win
    else
      player_two_win
    end
  end
  # This method is our nth-round game method.  It takes the value of rounds_to_win and loops the method until one of the players wins
  # that many rounds.  It also grabs the user input for moves through input methods to get the strings required.  This does allow
  # single round games as well, since rounds_to_win in that case would be 1
  #
  # This method takes no arguments, only reading existing attributes and returns from other methods getting user input
  #
  # This method doesn't explicitly return anything, and implicitly returns 0, the last expression, setting the player.score to 0
  def full_game
    until @player_one.score == @rounds_to_win || @player_two.score == @rounds_to_win
      round
    end
    
    if @player_one.score == @rounds_to_win
      @player_one.win
      player_one_win_game
    elsif @player_two.score == @rounds_to_win
      @player_two.win
      player_two_win_game
    end
    @player_one.reset_score
    @player_two.reset_score
  end
  
  def player_one_win
    return 1
  end
  
  def player_two_win
    return 2
  end
  
  def tie_round
    return 0
  end
  
  
  
  
  


  # Output method for our game winner.
  #
  # Returns nil
  def player_one_win_game
    puts "#{@player_one.name} wins the game!"
    puts "#{@player_one.name} has won #{@player_one.win_total} games so far!"
  end
  #Output method for our game winner.
  #
  # Returns nil
  def player_two_win_game
    puts "#{@player_two.name} wins the game!"
    puts "#{@player_two.name} has won #{@player_two.win_total} games so far!"
  end
end