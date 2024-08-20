require_relative("code")
require_relative("guess")

class Game
  def initialize
    @code = Code.new()
    @guesses = Array.new(8) {Guess.new()}
    @feedbacks = Array.new(8) {"----"}
  end

  def guess_feedback(guess, code)
    feedback = ""
    0.upto(guess.get_guess().length - 1) do |index|
      if guess.get_guess()[index] == code.get_code()[index]
        feedback += "."
      elsif code.get_code().split("").include?(guess.get_guess()[index])
        feedback += "?"
      else
        feedback += "!"
      end
    end
    return feedback
  end

  def guess_input()
    puts("Make your guess >>")
    input = gets.chomp
    until input.split("").all?{|char| ["1","2","3","4","5","6"].include?(char)} and input.length == 4
      puts("Your guess must be a string of 4 integers between 1 and 6 >>")
      input = gets.chomp
    end
    return input
  end

  def display_guesses()
    @guesses.each{|guess| puts(guess.get_guess())}
  end

  def display_feedbacks()
    @feedbacks.each{|feedback| puts feedback}
  end

  def play()
    #game is done when all guesses have been made
    until @guesses.all? {|guess| guess.guess_made?()}
      puts()
      display_feedbacks()
      #find first unmade guess
      unmade_guess = @guesses.find{|guess| not guess.guess_made?()}
      unmade_guess.make_guess(guess_input())
      #ungiven_feedback = @feedbacks.find{|feedback| feedback == "----"}
      #ungiven_feedback = guess_feedback(unmade_guess, @code)
      index = @feedbacks.find_index{|feedback| feedback == "----"}
      @feedbacks[index] = guess_feedback(unmade_guess, @code)
    end
  end
end