# frozen_string_literal: true

# gets secret word
class Dictionary
  def initialize
    @path = '5desk.txt'
  end

  def load
    @word_list = File.readlines(@path).select { |line| (5..12).include? line.strip.length }
                     .map { |word| word.strip.upcase }
  end

  def choose_secret_word
    @word_list[rand(0..@word_list.length)]
  end
end
