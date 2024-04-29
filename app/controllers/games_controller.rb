require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    alphabet = ('a'..'z').to_a
    @letters = []
    10.times { @letters << alphabet.sample }
  end

  def score
    @value = params[:word]
    @letters = params[:letters]
    @valid_word = word_api(@value)['found']
    @valid_compare = compare(@value, @letters)
  end

  def word_api(value)
    url = "https://wagon-dictionary.herokuapp.com/#{value}"
    url_serialized = URI.open(url).read
    JSON.parse(url_serialized)
  end

  def compare(input, letters)
    letters_tally = letters.downcase.chars.tally
    input_tally = input.downcase.chars.tally
    input_tally.all? do |key, value|
      letters_tally[key] && value <= letters_tally[key]
    end
  end
end
