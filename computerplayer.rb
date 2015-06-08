require_relative "game"
class ComputerPlayer < Player
  
  def initialize(name = "Computer")
    @name = name
    @move = ""
    @score = 0
    @win_total = 0
  end
  
end