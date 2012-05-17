require 'unicode'

# Module which parses user's input
# and gets general information about it
#
module Parser

  @data = [] # here we store all the words
  # regexp is used for removing all punctuation from the string
  @regexp = /[\:\_\-\*\(\)\#\$\%\|\^\&\ <>!\?;\.,\/\\]/

  # Parses the raw string into the array of words
  #
  def self.parse(input)
    @data = input.split(@regexp) 
    @data.reject! { |c| c.empty? }
    @data.map! { |c| Unicode.downcase(c) }
  end

  # Returns the array of words
  #
  def self.output
    @data
  end

  # Returns the number of the words in the 
  # produced array
  #
  def self.words_number
    @data.length
  end

  # Returns the first word in the produced
  # array or nil if there are no words
  #
  def self.first
    @data.first
  end

  # Returns the last word in the produced
  # array or nil if there are no words
  #
  def self.last
    @data.last
  end
end
