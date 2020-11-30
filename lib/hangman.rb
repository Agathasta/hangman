# frozen_string_literal: true

class UI
  def initialize
    @loader = Loader.new
  end

  def start
    answer_ln = ask_load_or_new until (%w[L N] & [answer_ln]).any?
    new_game if answer_ln == 'N'
    load_game if answer_ln == 'L'
    play
  end

  def ask_load_or_new
    puts 'Do you want to Load a saved game (L) or start a New game (N)?'
    gets.chomp.upcase
  end

  def new_game
    @word_list = @loader.load
    puts 'To save the game, type \'SAVE\' at any point'
    @game = Game.new(@word_list)
  end

  def load_game
    # recover -> SAVER
  end

  def play
    @game.play_round until @game.game_over? || @game.winner?
  end
end

class Loader
  def initialize
    @path = '5desk.txt'
  end

  def load
    File.readlines(@path).select { |line| (5..12).include? line.strip.length }
        .map { |word| word.strip.upcase }
  end
end

class Saver
  # def recover
  # jump you exactly back to where the player was when he saved
  # def save_game
  # serialize your game class!
end

class Game
  def initialize(word_list)
    @word_list = word_list
    @secret_word = choose_secret_word
    @display = { counter: 6, incorrect: '' }
    @board = (['_'] * @secret_word.length)
  end

  def choose_secret_word
    @word_list[rand(0..@word_list.length)]
  end

  def display_board
    puts @secret_word
    puts "COUNTER: #{@display[:counter]}\t INCORRECT GUESSES: #{@display[:incorrect]}"
    puts @board.join(' ')
  end

  def play_round
    display_board
    guess = ask_letter
    @display[:counter] -= 1 unless @secret_word.include?(guess)
    @display[:incorrect] += "#{guess} " unless @secret_word.include?(guess)
    @board = @board.map.with_index { |l, i| @secret_word[i] == guess ? guess.to_s : l }
  end

  def ask_letter
    puts 'Guess a letter:'
    print '> '
    gets.chomp.upcase
  end

  def game_over?
    return unless (@display[:counter]).zero?

    puts "GAME OVER, the secret word was #{@secret_word}"
    true
  end

  def winner?
    return unless @board.join == @secret_word

    puts @board.join(' ')
    puts 'You are amazing and won!!!'
    true
  end
end

UI.new.start
