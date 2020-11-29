class UI
  # Give options: A.Load B.New Game
  # if A.
    # recover -> SAVER
    # play
  # if B.
    # load in the dictionary -> LOADER
    # choose secret word -> LOADER
    # def play:
      # display board -> BOARD
      # loop
        # give options: A.Save B.Play UI
        # if A.
          # save_game SAVER
        # if B.
          # ask player to make a guess of a letter.
            # make it case insensitive.
        # update the display -> BOARD
        # break if game_over? || winner? -> BOARD
end

class Loader
  # load in the dictionary
  # def choose secret word
    # randomly select a word between 5 and 12 characters long for the secret word
    # make it case insensitive
end

class Saver
  # def recover
    # jump you exactly back to where the player was when he saved
  # def save_game
    # serialize your game class!
end

class Board
  # def display board
    # display counter so the player knows how many more incorrect guesses he/she has before the game ends. 
    # display which correct letters have already been chosen and their position in the word
    # display which incorrect letters have already been chosen.
  # def game_over
  # def winner
end
