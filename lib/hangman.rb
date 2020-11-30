# frozen_string_literal: true

require 'yaml'
require_relative 'dictionary'
require_relative 'turn'

# controls the initial setup of the game
class Hangman
  def initialize
    @dictionary = Dictionary.new
  end

  def ask_load_or_new
    puts `clear`
    puts '*** Hangman Game ***'
    puts
    puts 'Do you want to Load a saved game (L) or start a New game (N)?'
    print '> '
    gets.chomp.upcase
  end

  def start
    answer_ln = ask_load_or_new until (%w[L N] & [answer_ln]).any?
    new_game if answer_ln == 'N'
    load_game if answer_ln == 'L'
    play
  end

  def new_game
    @dictionary.load
    @secret_word = @dictionary.choose_secret_word
    @turn = Turn.new(@secret_word)
  end

  def load_game
    @turn = YAML.load(File.open('game.yml', 'r'))
    @turn.display_board
  end

  def play
    @turn.play_round until @turn.game_over? || @turn.winner?
  end
end

Hangman.new.start
