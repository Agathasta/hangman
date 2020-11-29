class UI
  def initialize
    @answer_ln = ask_load_or_new
    @loader = Loader.new
  end

  def ask_load_or_new
    puts 'Do you want to Load a saved game (L) or start a New game (N)?'
    gets.chomp.upcase
  end

  def ask_save
    puts 'Press S to save the game, any other key to continue playing'
    gets.chomp.upcase
  end

  def start
    if @answer_ln == 'N'
      @word_list = @loader.load
      @game = Game.new(@word_list)
    # elsif @answer_ln == 'L'
      # recover -> SAVER
    end
    play
  end

  def play
    loop do
      ask_save
      if @answer_s == 'S'
        puts "save"
        exit
      else
        @game.play_round
      end
      break if @game.game_over #|| @game.winner
    end
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
    @display = {counter: 7, incorrect: [], correct: [] }
    @board =  "_ " * @secret_word.length
    display_board
  end

  def choose_secret_word
    @word_list[rand(0..@word_list.length)]
  end

  def display_board
    puts @secret_word
    puts "COUNTER: #{@display[:counter]}\t INCORRECT GUESSES: #{@display[:incorrect]}\t CORRECT GUESSES: #{@display[:correct]}"
    puts @board
  end

  def play_round
    @display[:counter] -= 1
    guess = ask_letter
    @display[:correct] << guess if @secret_word.include?(guess)
    @display[:incorrect] << guess unless @secret_word.include?(guess)
    @board = @secret_word.chars.map {|l| l == guess ? l : "_"}.join(" ") # keep board!!!
    display_board
  end

  def ask_letter
    puts 'Guess'
    print '> '
    gets.chomp.upcase
  end

  def game_over
    @counter == 0
  end
  # def winner
end

UI.new.start