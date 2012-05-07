require 'set'
# encoding: utf-8
# Module for generating random
# sentence according to some input
#
module SentenceGenerator

  BIGRAMS_FILE = '2grams-3.txt'
  DIRECTORY = 'data/'

  MIN_WORDS = 3
  MAX_WORDS = 5

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
  def self.generate2(word)

    start_timer

    sentence = word
    file = File.open(DIRECTORY + BIGRAMS_FILE)

    (rand(MAX_WORDS - MIN_WORDS) + MIN_WORDS).times {
      return nil if time_over
      file.each do |line|
        tokens = line.split(' ')
        if tokens[1] == word
          sentence += ' ' + tokens[-1]
          word = tokens[-1]
          break
        end 
      end
    }
    file.close
    sentence
  end

  def self.generate(word)
    sentence = word
    start_timer
    (rand(MAX_WORDS - MIN_WORDS) + MIN_WORDS).times {
      return nil if time_over
      word = next_word(word)
      word ||= @used.to_a[rand(@used.size)] #cheating
      sentence += ' ' + word
    }
    while word.length < 4 || word.include?(' ') do
      return nil if time_over
      word = next_word(word)
      word ||= @used.to_a[rand(@used.size)] #cheating
      sentence += ' ' + word
    end
    sentence
  end

  private

  # Finds next word according to the last one
  #
  def self.next_word(word)
    file = File.open(DIRECTORY + BIGRAMS_FILE)
    file.each do |line|
        tokens = line.split(' ')
        if tokens[1] == word && !@used.include?(tokens[2])
          @used << tokens[-2]
          @used << tokens[-1]
          return tokens[2..-1].join(' ')
        end
    end 
    nil
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
    puts "Delay is " + (Time.now - @timer).to_s
    Time.now - @timer > MAX_DELAY
  end
end
