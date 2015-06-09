#Rock-Paper-Scissors Project

In this project, we had to come up with a Rock Paper Scissors game.  This project, along with coming up with the game, also was designed to test our ability to refactor code and to push us to apply SRP.  As the project layers, or "levels" grew, we went from a basic RPS game, to adding thorough documentation, and then making sure our classes looked clean and behaved as a class should.  Let's start going over the specific classes.

# Player

Our player class is our blueprint for each Player object we use.  My class has 4 attributes, and 3 methods, designed to modify our attributes in expected ways:

``` ruby

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
      # This method, win_round, increments the attribute @score when called.  It is used to allow our app.rb to 
      # keep track of how many rounds a player has won, and to allow it to set winning conditions.
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
      # This method, reset_score, allows us to reset the score in case of future games, while 
      # preserving the total number of wins the player has accrued
      #
      # This method accepts no arguments, and sets our @score attribute to 0
      #
      # The implicit return is the new value of our @score attribute, 0
      def reset_score
        @score = 0
      end
    end

```

The most common attribute modified in this class is our @move attribute.  We set this and check this attribute all throughout
our game.  This is why it is set as attr_accessor.

# Game

Our Game class is our next class.  This class caused me the most difficulty in this assignment, because of the way I decided to factor the code to begin with.  Going back and taking out the gets/puts methods caused me pain, but I believe the final product looks good and fulfills the properties and requirements of our assignment:

``` ruby

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
      # This method is our round.  It takes each player's move and checks it against our list of allowable moves.
      # Whichever player wins, it will increment their score and call the correct output text for that outcome. 
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
    
```

The blueprint is in charge of having the number of rounds it takes to win, set as our @rounds_to_win attribute.  Our player objects are stored here as attributes, however they are not created here.  They are created in our GameDriver class, which we'll reference later.  The Game class also has an allowed set of moves, listed as an Array in the attribute @allowed_moves.  Our methods check our players' moves against the allowed moveset, and then is our judge for the winner of each round.  

The @allowed_moves attribute differentiates this type of game against our variation game, 'Rock Paper Scissors Lizard Spock', or RPSLS for short.  Our subclass containing this game has a bit of different logic for determining a winner, a necessity when you have 5 possible moves and each move has two that it wins again, and two it loses against.  The round method is shorter here as it only has to have logic for three moves, and one winner/loser per move.  Here's the differences in RPSLS over RPS:

``` ruby
       @allowed_moves = %w(spock lizard rock paper scissors)
```
and
``` ruby
    def round
      if @allowed_moves.index(@player_one.move) == @allowed_moves.index(@player_two.move)
        0
      elsif (@allowed_moves.index(@player_one.move) - 1) == @allowed_moves.index(@player_two.move)
        1
      elsif @allowed_moves.index(@player_one.move) == 0 && @allowed_moves.index(@player_two.move) == 4
        1
      elsif (@allowed_moves.index(@player_one.move) + 2) == @allowed_moves.index(@player_two.move)
        1
      elsif @allowed_moves.index(@player_one.move) == 3 && @allowed_moves.index(@player_two.move) == 0
        1
      elsif @allowed_moves.index(@player_one.move) == 4 && @allowed_moves.index(@player_two.move) == 1
        1
      else
        2
      end
    end
```

as RPSLS is a subclass of RPS, it inherits everything we don't specifically define differently from the superclass (in this case, Game).

# GameDriver

Our GameDriver class is where we plug our code in and acts as a driver for our app.rb interface with the user.  Usually we wouldn't use puts and gets in classes, but it was acceptable here because this is where we are wanting to grab our information to plug into our classes.  Our classes don't need to know this information specifically themselves, they are just objects acting on data acquired elsewhere.  GameDriver is where we are acquiring this data.  GameDriver is where our logic for multi-round games is going, and where the user picks which game to play (and thus which object to instantiate, Game or RPSLSGame).  It also prompts the user for names and instantiates our Player objects.  We could get all of this input and the text output elsewhere, and therefore we could use our Player/Game/RPSLSGame classes outside of this project, however GameDriver would be pretty defunct, as the ways to get input/output would be different than just command line prompting.  Because of this, I won't show the code for my GameDriver, but it is a semi-vital file as of right now because of our lack of other input/output medium.

# Summary

I thought this project went in waves for myself.  It started pretty easy as we built up, and even up through getting into Level 3 implementations of RPSLS and the GameDriver classes.  My difficulty came with how I proceeded through these steps however, and I caused myself pretty severe headaches by putting input/output in the base Game class, which made me refactor that all out at a later time.  Once I got them refactored out, I was able to keep the same functionality, and allow my classes to much better serve their purpose, as simple blueprints, and not as interfaces as well.  I do think this was part of the purpose of this assignment, and even though it caused me a big pain to have to refactor with how I proceeded through, I think in the end it was a better practice on how to refactor my code.