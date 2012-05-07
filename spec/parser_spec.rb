# encoding: utf-8
#
require 'minitest/autorun'
require_relative '../lib/parser'

# Tests Parser module
#
describe Parser do
  
  # Asserts generated by Parsre array
  #
  def assert_output(string, array)
    Parser.parse(string)
    Parser.output.must_equal array
  end

  # Asserts length of generated by Parser array
  #
  def assert_count(string, num)
    Parser.parse(string)
    Parser.words_number.must_equal num
  end

  # Asserts the first word of generated
  # by Parser array
  #
  def assert_first(string, first)
    Parser.parse(string)
    Parser.first.must_equal first
  end

  # Asserts the last word of generated
  # by Parser array
  #
  def assert_last(string, last)
    Parser.parse(string)
    Parser.last.must_equal last
  end

  it "should process strings without punctuation" do
    assert_output("first second third", ["first", "second", "third"])
    assert_output("a b c ", ['a', 'b', 'c'])
  end

  it "should process strings with punctuation" do
    assert_output("a:, b.?! c", ['a', 'b', 'c'])
    assert_output(" _-a*b:c", ['a', 'b', 'c'])
  end

  it "should process empty strings" do
    assert_output("  -!?&", [])
  end

  it "should correctly count words" do
    assert_count("a b c d", 4)
    assert_count(" a! b, c? d:", 4)
    assert_count(" ", 0)  
  end

  it "should return the first word" do
    assert_first("я ты он она", "я")
    assert_first("...но мысли мои были", "но")
  end

  it "should return the last word" do
    assert_last("где-то на белом свете", "свете")
    assert_last("там, где всегда мороз!", "мороз")
  end
end
