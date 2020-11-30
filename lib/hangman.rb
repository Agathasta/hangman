# frozen_string_literal: true

require 'yaml'

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
    puts `clear`
    puts '*** Hangman ***'
    puts 'Do you want to Load a saved game (L) or start a New game (N)?'
    gets.chomp.upcase
  end

  def new_game
    @word_list = @loader.load
    @game = Game.new(@word_list)
  end

  # def load_game
  #   @game.load_game
  # end

  def load_game
    saved = File.open("game.yaml", 'r')
    loaded_game = YAML.load(saved)
    saved.close
    @game = loaded_game
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
  # def save_game
  # serialize your game class!
  # def recover
  # jump you exactly back to where the player was when he saved
end

class Game
  def initialize(word_list)
    @word_list = word_list
    @secret_word = choose_secret_word
    @counter = 6
    @incorrect = ''
    @board = (['_'] * @secret_word.length)
  end

  def choose_secret_word
    @word_list[rand(0..@word_list.length)]
  end

  def display_board
    puts `clear`
    puts '*** Hangman ***'
    puts 'To save the game, type \'SAVE\' at any point'
    puts
    puts "GUESSES REMAINING: #{@counter}\t INCORRECT GUESSES: #{@incorrect}"
    puts @board.join(' ')
  end

  def play_round
    display_board
    @guess = ask_letter
    @guess == 'SAVE' ? save_game : update_display_board
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
    File.open("game.yaml", 'w') { |file| file.write YAML.dump(self) }
    exit
  end

  def game_over?
    return unless (@counter).zero?

    puts "GAME OVER, the secret word was #{@secret_word}"
    puts
    true
  end

  def winner?
    return unless @board.join == @secret_word

    puts @board.join(' ')
    puts 'You are amazing and won!!!'
    puts
    true
  end
end

UI.new.start
