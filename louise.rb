# coding: UTF-8
require 'sinatra'
require_relative 'lib/simulator'

# Represents the web server which 
# accepts only certain kinds of requests
# to it. All responses are haml pages which
# support html5 features.
#
class SimServer < Sinatra::Base

  DELIM ||= '&#10;'
  PROMPT = '> '

  # Get request to the application root.
  # Redirects to the index page.
  #
  get '/' do
    haml :index, format: :html5
  end
  
  # Index page. Includes only static 
  # information
  #
  get '/index.haml' do
    haml :index, format: :html5
  end

  # About page. Includes only static
  # information
  #
  get '/about.haml' do
    haml :about, format: :html5
  end

  # Conversation page, get request. 
  # Shows the conversation page without
  # any external data on it
  #
  get '/conversation.haml' do
    haml :conversation, format: :html5
  end

  # Post request to the conversation page.
  # Gets user input and uses internal library
  # to produce the response
  #
  post '/conversation.haml' do
    phrase = params['phrase'] || ''
    history = params['data']

    response = PROMPT + Simulator.process(phrase)

    @resp = history.nil? ? '' : history
    @resp += PROMPT + phrase + DELIM 
    @resp += response + DELIM

    haml :conversation, format: :html5
  end

  # Shows the 404 Error message
  #
  get // do
    haml :error404, format: :html5
  end
end

SimServer.run!
