# frozen_string_literal: true

# plays the game
class Turn
  def initialize(secret_word)
    @secret_word = secret_word
    @counter = 6
    @incorrect = ''
    @board = (['_'] * @secret_word.length)
    display_board
  end

  def display_board
    puts `clear`
    puts '*** Hangman Game ***'
    puts
    puts 'To save the game, type [SAVE] at any point'
    puts
    puts "Guesses remaining: #{@counter} of 6"
    puts "Incorrect guesses: #{@incorrect}"
    puts "Correct guesses: #{@board.join(' ')}"
  end

  def play_round
    @guess = ask_letter
    @guess == 'SAVE' ? save_game : update_display_board
    display_board
  end

  def ask_letter
    puts
    puts 'Guess a letter:'
    print '> '
    gets.chomp.upcase
  end

  def update_display_board
    @counter -= 1 unless @secret_word.include?(@guess)
    @incorrect += "#{@guess} " unless @secret_word.include?(@guess)
    @board = @board.map.with_index { |l, i| @secret_word[i] == @guess ? @guess.to_s : l }
  end

  def save_game
    File.open('game.yml', 'w') { |file| file.write YAML.dump(self) }
    exit
  end

  def game_over?
    return unless @counter.zero?

    puts
    puts "GAME OVER, the secret word was #{@secret_word}"
    puts
    true
  end

  def winner?
    return unless @board.join == @secret_word

    puts
    puts @board.join(' ')
    puts 'You are amazing and won!!!'
    puts
    true
  end
end
