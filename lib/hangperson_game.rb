class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = "" 
    @wrong_guesses = "" 
#    byebug

  end

  attr_accessor :word, :guesses, :wrong_guesses
  
    #`guess`, which processes a guess and modifies the instance variables 
  # `wrong_guesses` and `guesses` accordingly;
  def guess(letters)
    raise ArgumentError if letters == ""
    raise ArgumentError if letters !~ %r{\w}
    letters.downcase!
      if  @word.include?(letters) 
        !@guesses.include?(letters) ? @guesses << letters : false

      else
        @wrong_guesses.include?(letters) ? false : wrong_guesses << letters 
      end
  end 
  
  # `check_win_or_lose`, which returns one of the symbols
  # `:win`, `:lose`, or `:play` depending on the current game state
  def check_win_or_lose
 
    if ( @wrong_guesses.length ==  7 ) 
     :lose
    elsif ( ! self.word_with_guesses.include?("-") )
       :win
    else
      :play
    end

  end 
  
  # `word_with_guesses`, substitute correct guesses into the word.
  #
  #  INSANE ...  
  #
  def word_with_guesses
    guesses_list = @guesses.to_s
    guesses_rx = /[^ #{guesses_list}]/
    @masked = @word.gsub(guesses_rx, "-")
    @masked.scan(/[a-z\-]/).join
  end
  
  # Get a word from remote "random word" service

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
