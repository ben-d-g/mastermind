require_relative("code")
require_relative("guess")

class Game
  def initialize
    @code = Code.new()
    @guesses = Array.new(8) {Guess.new()}
  end

  def guess_feedback(guess, code)
    feedback = ""
    0.upto(guess.get_guess().length - 1) do |index|
      if guess.get_guess()[index] == code.get_code()[index]
        feedback += "."
      elsif code.get_code().split("").includes?(guess.get_guess()[index])
        feedback += "?"
      else
        feedback += "!"
      end
    end
    return feedback
  end

  def feedback_input()
    puts("Make your guess >>")
    input = gets.chomp
    until input.split("").all?{|char| ["1","2","3","4","5","6"].include?(char)} and input.length == 4
      puts("Your guess must be a string of 4 integers between 1 and 6 >>")
      input = gets.chomp
    end
  end

  def play()
    #game is done when all guesses have been made
    until @guesses.all? {|guess| guess.guess_made?()}
      x=1
    end
  end
end