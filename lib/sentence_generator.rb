# encoding: utf-8
# Module for generating random
# sentence according to some input
module SentenceGenerator

  BIGRAMS_FILE = '2grams-3.txt'

  # Generates some random sentence
  # according to the last word
  # of the previous response.
  # Uses the most frequent combinations
  # of word sequences in order to construct
  # a sentence
  #
  def self.generate(last)
    f = File.open(BIGRAMS_FILE)
    sentence = last
    (rand(3) + 4).times {
      f.each do |line|
        #return 'ну ты прямо в тупик поставил'
        tokens = line.split(' ')
        if tokens[1] == last
          sentence += ' ' + tokens[-1]
          last = tokens[-1]
          break
        end 
      end
    }
    sentence
  end
end
