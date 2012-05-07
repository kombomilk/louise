# encoding: utf-8
#
require 'minitest/autorun'
require_relative '../lib/data_initializer'

describe DataInitializer do

  it "should fill necessary arrays" do
    DataInitializer.read_data
    DataInitializer::GREETINGS.wont_be_empty
    DataInitializer::GOODBYES.wont_be_empty
    DataInitializer::QUOTATIONS.wont_be_empty
    DataInitializer::INADEQUATE.wont_be_empty
    DataInitializer::ON_EMPTY.wont_be_empty
  end

  it "should return random element of array" do
    DataInitializer.read_data
    DataInitializer::GREETINGS.must_include DataInitializer.random_greeting
    DataInitializer::GOODBYES.must_include DataInitializer.random_goodbye
    DataInitializer::QUOTATIONS.must_include DataInitializer.random_quotation
    DataInitializer::INADEQUATE.must_include DataInitializer.random_inadequate
    DataInitializer::ON_EMPTY.must_include DataInitializer.random_on_empty
  end
end

