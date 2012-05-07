require_relative 'parser'
require_relative 'data_initializer'
require_relative 'sentence_generator'

# Simulator conversation itself.
# It processes user's input and tries to 
# recognize common patterns. After processing
# it produces some kind of output which 
# should be logically related to the input
#
module Simulator

  # The only method which processe input
  # and produces appropriate output
  #
  def self.process(input)
    Parser.parse(input)
    data = Parser.output
    if data.length == 0
      DataInitializer.random_on_empty
    elsif data.length < 3 && (response = greeting_or_goodbye(data)) != nil
      response
    else
      generated = SentenceGenerator.generate(data[-1]) 
      generated || (Time.now.sec.even? ? DataInitializer.random_inadequate : DataInitializer.random_quotation)
    end
  end

  private

  # Processes empty user input
  #
  def self.process_empty
    DataInitializer.random_on_empty
  end  

  def self.greeting_or_goodbye(data)
    piece = data.join(' ')
    if DataInitializer::GREETINGS.include?(piece)
     DataInitializer.random_greeting 
    elsif DataInitializer::GOODBYES.include?(piece)
      DataInitializer.random_goodbye
    else
      nil
    end
  end
end
