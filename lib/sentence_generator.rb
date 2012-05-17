require 'set'
require 'unicode'
require_relative 'punctuation'

# encoding: utf-8
#
# Module for generating random
# sentence according to some input
#
module SentenceGenerator

  BIGRAMS_FILE = '2grams-3.txt'
  TRIGRAMS_FILE = '3grams-3.txt'
  DIRECTORY = 'data/'

  MIN_WORDS = 2
  MAX_WORDS = 4

  MAX_DELAY = 20 # in seconds maximum time of algorithm run

  @timer = 0
  @used = Set.new

  # Generates some random sentence
  # according to the last word
  # of the previous response.
  # Uses the most frequent combinations
  # of word sequences in order to construct
  # a sentence
  #
  def self.generate(word)
    sentence = [word]
    start_timer
    words_number = rand(MAX_WORDS - MIN_WORDS) + MIN_WORDS
    while words_number > 0 || word.length < 3 do
      return nil if time_over
      word = next_word(sentence)
      #word = @used.to_a[rand(@used.size)]
      word ||= @used.to_a[rand(@used.size)] if rand(10) < 8
      word ||= next_word(sentence[0..-2])
      return DataInitializer.random_inadequate if word.nil?
      sentence << word
      sentence.flatten!
      words_number -= 1
    end
    Punctuation.arrange(sentence.join(' '))
  end

  private

  # Finds next word according to the last one
  #
  def self.next_word(sentence)
    word = sentence[rand(sentence.length)]
    file = File.open(DIRECTORY + TRIGRAMS_FILE)
    file.each do |line|
      tokens = line.split(' ').map { |c| Unicode.downcase(c) }
      if sentence[-2..-1] == tokens[-3..-2]
        @used << tokens[-1]
        return tokens[-1]
      end
    end
    file.close

    file = File.open(DIRECTORY + BIGRAMS_FILE)
    file.each do |line|
      tokens = line.split(' ').map { |c| Unicode.downcase(c) }
      if tokens[1] == word && !@used.include?(tokens[2])
        @used << tokens[-2]
        @used << tokens[-1]
        return tokens[2..-1]
      end
    end 
    file.close

    nil # Return nil if we found nothing
  end

  # Saves the current time in order to 
  # calculate the working time of the
  # algorithm
  #
  def self.start_timer
    @timer = Time.now
  end

  # Checks if the time is over as
  # compared with the maximal
  # delay of algorithm work time
  #
  def self.time_over
    Time.now - @timer > MAX_DELAY
  end
end
