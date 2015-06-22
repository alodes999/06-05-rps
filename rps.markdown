#Rock-Paper-Scissors Project

In this project, we had to come up with a Rock Paper Scissors game.  This project, along with coming up with the game, also was
designed to test our ability to refactor code and to push us to apply SRP.  As the project layers, or "levels" grew, we went from a
basic RPS game, to adding thorough documentation, and then making sure our classes looked clean and behaved as a class should.  Let's
start going over the specific classes.

## Player

Our player class is our blueprint for each Player object we use.  My class has 4 attributes, and 3 methods, designed to modify our
attributes. Our class is initialized with 4 attributes.  they are:

``` ruby

    attr_reader :name, :score, :win_total
    attr_accessor :move
    
    def initialize(name)
      @name = name
      @move = ""
      @score = 0
      @win_total = 0
    end
    
```

All of the attributes outside of @move were there to hold information.  The @move attribute was pretty integral to the rest of the
program, so we had to modify it as the program went along, as well as read it.

My method here was used as our score keeping method.  When a player won a round, this method was called to increment their score.  We
could have set this attribute in our accessor area, but I opted to keep it as a reader only.  My thinking behind this was that I didn't
need to set the score elsewhere in the program, only modify it through the methods I would create.  Had I needed to dynamically set the
score, then I would have put it as an accessor as well.  My win_round method, that increments the score: 

``` ruby
   
    def win_round
      @score += 1
    end
    
```

My method here was used to increment our @win_total attribute.  Using the same thinking as above, I set this attribute as read only
because again, I didn't think I would need to dynamically set this figure outside the class, that my method here would handle it:

``` ruby

    def win
      @win_total += 1
    end
    
``` 

My method here, reset_score, was my ability to reset the score of the player to 0 for each game.  It's helpful for when multiple
games are being run in order.  My app.rb allows for multiple games to run one after another, so this method would be helpful for
resetting the score for each game, and because it's set as a method, I can keep the score attribute safe as a reader, instead of
having to open it up as an accessor.

``` ruby

    def reset_score
      @score = 0
    end

```

## Game

Our Game class is our next class.  This class caused me the most difficulty in this assignment, because of the way I decided to factor
the code to begin with.  Going back and taking out the gets/puts methods caused me pain, but I believe the final product looks good and
fulfills the properties and requirements of our assignment.

Our initialize method sets our parameters for each Game object:

``` ruby

      attr_reader :rounds_to_win, :allowed_moves
      attr_accessor :player_one, :player_two 

      def initialize(player_one, player_two, best_of)
        @rounds_to_win = ((best_of / 2.0).floor) + 1
        @player_one = player_one
        @player_two = player_two
        @allowed_moves = %w(rock paper scissors)
      end
      
```

We have our rounds_to_win, an attribute that is passed an integer that defines how many rounds a player has to win to win a game.
This attribute is handy because we can look at the value and compare our player scores to know if they have won the overall game,
or if there are more rounds to play.

We also have our @allowed_moves attribute, the set of moves that our methods will check the move stored in our Player objects against
for validity.

@player_one and @player _two are our player attributes.  They are actual Player objects stored as the attributes here.  Our GameDriver
instantiates these, and passes them to our Game as the arguments when we call this class.  This way, we can look at the attributes'
(the Player's) move to compare in our next method:

``` ruby

      def check_move(move_to_check)
        @allowed_moves.include?(move_to_check.downcase)
      end
      
```

Because we run this check, we can safely use the move in our Player.move attribute to check our game logic:

``` ruby
     
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
    
```
The reason I use this if/else block is that early on when doing the RPS pre-work assignments, I saw a pattern in how moves were set up
in that array.  Another perfectly viable option to avoid using this kind of if/else block is to set each move into a hash, containing a 
move, and the move it beats, and then checking to see if the players' moves match that hash. 

The @allowed_moves attribute differentiates this type of game against our variation game, 'Rock Paper Scissors Lizard Spock', or RPSLS
for short.  Our subclass containing this game has a bit of different logic for determining a winner, a necessity when you have 5 
possible moves and each move has two that it wins again, and two it loses against.  The round method is shorter here as it only has to
have logic for three moves, and one winner/loser per move.  Here's the differences in RPSLS over RPS:

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

The biggest "ah-ha" moment of this project was discussing my refactoring issues, in particular making the Game handle a multi-round
game. Sumeet told me that it's "not in the nature of Game to run a game". As weird as it sounded, it clicked that I was still trying to
use Game outside of it's purpose, namely being a judge and defining the moveset of the game, and it helped immensely.

## GameDriver

Our GameDriver class is where we plug our code in and acts as a driver for our app.rb interface with the user.  Usually we wouldn't use 
puts and gets in classes, but it was acceptable here because this is where we are wanting to grab our information to plug into our 
classes.  Our classes don't need to know this information specifically themselves, they are just objects acting on data acquired 
elsewhere.  GameDriver is where we are acquiring this data.  GameDriver is where our logic for multi-round games is going, and where
the user picks which game to play (and thus which object to instantiate, Game or RPSLSGame).  It also prompts the user for names and
instantiates our Player objects.  We could get all of this input and the text output elsewhere, and therefore we could use our
Player/Game/RPSLSGame classes outside of this project, however GameDriver would be pretty defunct, as the ways to get input/output
would be different than just command line prompting.  Because of this, I won't show the code for my GameDriver, but it is a semi-vital
file as of right now because of our lack of other input/output medium.

# Summary

I thought this project went in waves for myself.  It started pretty easy as we built up, and even up through getting into Level 3
implementations of RPSLS and the GameDriver classes.  My difficulty came with how I proceeded through these steps however, and I caused
myself pretty severe headaches by putting input/output in the base Game class, which made me refactor that all out at a later time. 
Once I got them refactored out, I was able to keep the same functionality, and allow my classes to much better serve their purpose, as
simple blueprints, and not as interfaces as well.  I do think this was part of the purpose of this assignment, and even though it
caused me a big pain to have to refactor with how I proceeded through, I think in the end it was a better practice on how to refactor
my code.