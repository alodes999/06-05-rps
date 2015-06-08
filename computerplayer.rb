require_relative "game"
class ComputerPlayer < Player
  
  def initialize(name = "Computer")
    @name = name
    @move = ""
    @score = 0
    @win_total = 0
  end
  
  def set_moves_rps
    @move_set = %w(rock paper scissors)
  end
  
  def set_moves_rpsls
    @move_set = %w(spock lizard rock paper scissors)
  end
  
  def get_move
    @move = @move_set.sample
  end
end