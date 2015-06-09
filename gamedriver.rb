# This is our GameDriver class.  It is like a "launcher" for any game we want to run.  We instantiate this class, and it
# gets the input needed to pick the correct game class and run that.
require_relative "rpslsgame"
require_relative "computerplayer"
class GameDriver
  # This is our initialize method for the GameDriver class.  We are accepting no arguments when initializing each object, 
  # because we are getting the attributes from the methods we run.  This object is the "launcher" of whatever game we decide
  # we want to run.
  #
  # We have 5 attributes
  # => @game_choice, nil to start, will be a string of the game choice picked.  Will be used to initialize the correct game object
  # => @best_of, nil to start, will be an integer for the rounds of the game played
  # => @player_one, nil to start, will be a Player object for player one
  # => @player_two, nil to start, will be a Player object for player two
  # => @available_games, an array of the games we have available to play
  def initialize
    @game_choice = nil
    @best_of = nil
    @player_one = nil
    @player_two = nil
    @available_games = ["rps", "rpsls"]
  end
  # This method sets our first player.  Getting user input will set the corresponding attribute for our object.
  #
  # Sets the attribute @player_one.
  #
  # Returns the object created.
  def set_player_one
    puts "Player 1, please enter your name, or Computer for a computer player."
    p1name = gets.chomp
    @player_one = Player.new(p1name)
    end
  end
  # This method sets our second player.  Getting user input will set the corresponding attribute for our object.
  #
  # Sets the attribute @player_two.
  #
  # Returns the object created
  def set_player_two
    puts "Player 2, please enter your name, or Computer for a computer player."
    p2name = gets.chomp
    @player_two = Player.new(p2name)
    end
  end
  # This method sets our game choice.  User input sets the corresponding attribute for our object.  Checks to see
  # if the entered name is a valid game choice before setting our attribute
  #
  # Sets the attribute @game_choice
  #
  # Returns the entered string
  def choose_game
    puts "Which game would you like to play? Enter RPS for the regular game, or RPSLS for 'Rock, Paper, Scissors, Lizard, Spock'"
    choice = gets.chomp.downcase
    while @available_games.include?(choice) == false
      puts "That is not a valid game choice.  Please reenter the choice"
      choice = gets.chomp.downcase
    end
    @game_choice = choice
  end
  # This method sets the number of rounds desired for our chosen game.  User input sets the corresponding attribute for our
  # object.  This method only allows an odd number between 1 and 7, otherwise will get a new number from the user
  #
  # Sets the attribute @best_of
  #
  # Returns the entered integer
  def rounds
    puts "Best of how many games? (Please input an odd number)"
    best_of = gets.chomp.to_i
    while best_of % 2 == 0 || best_of >= 9
      puts "Please reenter an odd number of games.  You either put in an even number, or the game is too long."
      best_of = gets.chomp.to_i
    end
    @best_of = best_of
  end
  # This method starts the correct game, based on the choice picked by the user.  This inserts the correct object attributes and
  # passes them as the correct arguments into the various game instantiation calls.  It then runs the corresponding game.
  #
  # Initializes the correct game object based on the setting of our @game_choice attribute.  Passes the @player_one_name,
  # @player_two_name, and @best_of attributes to the corresponding game class.
  #
  # Returns a new Game object, defined from the attributes.
  def start_game
    if @game_choice == "rps"
      game1 = Game.new(@player_one, @player_two, @best_of)
    elsif @game_choice == "rpsls"
      game1 = RPSLSGame.new(@player_one, @player_two, @best_of)
    end
  end
  
  def get_moves
    puts "#{@player_one.name}, please enter a move:"
    gets.chomp

    p1move = get_player_one_move
    game1.check_move(p1move)
    while false
      puts "That was an invalid move.  Please re-enter a move:"
      p1move = gets.chomp
      game1.check_move(p1move)
    end
    @player_one.move = p1move

    puts "#{@player_two.name}, please enter a move:"
    gets.chomp

    p2move = get_player_two_move
    game1.check_move(p2move)
    while false
      puts "That was an invalid move.  Please re-enter a move:"
      p2move = gets.chomp
      game1.check_move(p2move)
    end
    @player_two.move = p2move
  end
  
  def run_round
    get_moves
    game1.round
    if 0
      puts "This round is a tie!  Both players selected #{@player_one.move}"
    elsif 1
      puts "#{@player_one.move} beats #{@player_two.move}! #{@player_one.name} wins this round!"
    else
      puts "#{@player_two.move} beats #{@player_one.move}! #{@player_two.name} wins this round!"
    end
    show_score
  end
  
  def show_score
    puts "The score is #{@player_one.name}: #{@player_one.score}, and #{@player_two.name}: #{@player_two.score}"
  end
  
  
end