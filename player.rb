# Player class that instantiates different player objects to be used in our RPS game.

class Player
  attr_reader :name, :score, :win_total
  attr_accessor :move
  # There is one argument for each instance, the name.
  #
  # The class has 4 attributes:
  # => name - a string of the player's name
  # => move - an integer storing the index of the players last move
  # => score - an integer storing each rounds' current score
  # => win_total - an integer storing the number of overall games the player has won.
  #  
  def initialize(name)
    @name = name
    @move = ""
    @score = 0
    @win_total = 0
  end
  # This method, win_round, increments the attribute @score when called.  It is used to allow our app.rb to keep track of how many rounds a player has won, and to allow it to set winning conditions.
  #
  # This method accepts no arguments, and increments our @score attribute by one
  #
  # The method implicitly returns the new value of our @score method.
  def win_round
    @score += 1
  end
  # This method, win_game, increments our attribute @win_total when called.
  #
  # This method accepts no arguments, and increments our @win_total attribute by one
  #
  # The implicit return is the new value of our @win_total attribute 
  def win
    @win_total += 1
  end
  # This method, reset_score, allows us to reset the score in case of future games, while preserving the total number of wins the player has accrued
  #
  # This method accepts no arguments, and sets our @score attribute to 0
  #
  # The implicit return is the new value of our @score attribute, 0
  def reset_score
    @score = 0
  end
end