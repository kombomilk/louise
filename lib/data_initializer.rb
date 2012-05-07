# Module initializes all the 
# necessary data for conversation.
# It reads information from files into 
# static arrays which can be accessible from
# other modules or classes
#
module DataInitializer

  GREETINGS = []
  GOODBYES = []
  QUOTATIONS = []
  INADEQUATE = []
  ON_EMPTY = []

  # Reads all the data from files
  #
  def self.read_data
    read_into_array(GREETINGS_FILE, GREETINGS)
    read_into_array(GOODBYES_FILE, GOODBYES)
    read_into_array(QUOTATIONS_FILE, QUOTATIONS)
    read_into_array(INADEQUATE_FILE, INADEQUATE)
    read_into_array(ON_EMPTY_FILE, ON_EMPTY)
  end

  # Checks whether the data is initialized
  #
  def self.initialized?
    !GREETINGS.empty?
  end

  # Returns random greeting
  #
  def self.random_greeting
    random_element(GREETINGS)
  end

  # Returns random goodbye
  #
  def self.random_goodbye
    random_element(GOODBYES)
  end

  # Returns random quotation
  #
  def self.random_quotation
    random_element(QUOTATIONS)
  end

  # Returns random inadequate
  #
  def self.random_inadequate
    random_element(INADEQUATE)
  end

  # Returns random response on empty input
  #
  def self.random_on_empty
    random_element(ON_EMPTY)
  end

  private

  # Returns random element of the array
  def self.random_element(array)
    array[rand(array.length)]
  end

  DIR = 'data/'
  GREETINGS_FILE = 'greetings.txt'
  GOODBYES_FILE = 'goodbyes.txt'
  INADEQUATE_FILE = 'inadequate_responses.txt'
  QUOTATIONS_FILE = 'quotations.txt'
  ON_EMPTY_FILE = 'response_on_empty.txt'
 
  # Reads data into array from some file
  #
  def self.read_into_array(filename, array)
    file = File.new(DIR + filename, 'r')
    while (line = file.gets)
      array << line.chomp
    end
    array.compact!
    file.close
  end
end
