class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  # def initialize()
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  # Updates the correct guess word and returns true if the user
  # enters the correct guess, otherwise returns false
  def guess(letter)
    if letter.nil?
      raise ArgumentError.new("Guess in nil")
    end

    if letter.empty?
      raise ArgumentError.new("Guess is empty") 
    end

    if /[^a-zA-Z]/ =~ (letter)
      raise ArgumentError.new("Guess is not a letter")
    end 

    if !@guesses.include?(letter.downcase) &&
     !@wrong_guesses.include?(letter.downcase)
        if @word.include?(letter)
          @guesses << letter.downcase
        else 
          @wrong_guesses << letter.downcase
        end
        return true
    else
      return false
    end
  end

  # => helper method to help create the dislpay string
  def create_dashed_display_string(word)
    guess_string = ""
    word.length.times {
      guess_string << "-"
    }
    guess_string
  end

  # => inserts the correclty guessed letter into the string
  def insert_guess_letter_to_dash(display_word, guesses, word)
      guesses.each_char { |guess_char|
      word.each_char.with_index{ |word_char, index|
        if guess_char == word_char
          display_word[index] = guess_char
        end
      }
    }
    return display_word
  end

  # => returns a string that displays all the guess word
  # => with the correctly guessed letters visible
  def word_with_guesses
    display_word = create_dashed_display_string(@word)
    display_word = insert_guess_letter_to_dash(display_word, @guesses, @word)
    # => display_word
  end


  # Get a word from remote "random word" service
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
