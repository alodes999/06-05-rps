# This contains the Game class for our RPS program.
require_relative "player"
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
      @player_one.win_round
      player_one_win_speech
    elsif @allowed_moves.index(@player_one.move) == 0 && @allowed_moves.index(@player_two.move) == 2
      @player_one.win_round
      player_one_win_speech
    else
      @player_two.win_round
      player_two_win_speech
    end
    show_score
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
      set_player_one_move
      set_player_two_move
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
  # Method that gets the user input for the move for player one in our game
  #
  # Returns the entered string
  def get_player_one_move
    puts "#{@player_one.name}, please enter a move:"
    gets.chomp
  end
  # Method that checks to make sure the user input for player one is valid, and sets player one's move to this input.
  #
  # Returns the string with the valid move
  def set_player_one_move
    p1move = get_player_one_move
    check_move(p1move)
    while check_move(p1move) == false
      p1move = re_get_player_move
      check_move(p1move)
    end
    @player_one.move = p1move
    end
  end
  # Method that sets the user input for the move for player two in our game
  #
  # Returns the entered string
  def get_player_two_move
    puts "#{@player_two.name}, please enter a move:"
    gets.chomp
  end
  # Method that checks to make sure the user input for player two is valid, and sets player two's move to this input.
  #
  # Returns the string with the valid move
  def set_player_two_move
    p2move = get_player_two_move
    check_move(p2move)
    while check_move(p2move) == false
      p2move = re_get_player_move
      check_move(p2move)
    end
    @player_two.move = p2move
  end
  # Method that sets the user input for any incorrect move entered in our game
  #
  # Returns the entered string
  def re_get_player_move
    puts "That was an invalid move, please re-enter a move:"
    gets.chomp
  end 
  # Output method for our round method
  #
  # Returns nil
  def tie_round
    puts "This round is a tie!  Both players selected #{@player_one.move}"
  end
  # Output method for our round method
  #
  # Returns nil
  def player_one_win_speech
    puts "#{@player_one.move} beats #{@player_two.move}! #{@player_one.name} wins this round!"
  end
  # Output method for our round method
  #
  # Returns nil
  def player_two_win_speech
    puts "#{@player_two.move} beats #{@player_one.move}! #{@player_two.name} wins this round!"
  end
  # Output method for our round method
  #
  # Returns nil
  def show_score
    puts "The score is #{@player_one.name}: #{@player_one.score}, and #{@player_two.name}: #{@player_two.score}"
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