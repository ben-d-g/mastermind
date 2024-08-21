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
    puts("Enter your code >>")
    input = gets.chomp
    until input.split("").all?{|char| ["1","2","3","4","5","6"].include?(char)} and input.length == 4
      puts("Your code must be a string of 4 integers between 1 and 6 >>")
      input = gets.chomp
    end
    return input
  end

  def generate_guess()
    chars = ["1", "2", "3", "4", "5", "6"]
    randomString = ""
    1.upto(4){randomString += chars.sample}
    return randomString
  end

  def display_guesses()
    @guesses.each{|guess| puts(guess.get_guess())}
  end

  def display_feedbacks()
    @feedbacks.each{|feedback| puts feedback}
  end

  def play_human_guessing()
    #game is done when all guesses have been made
    until @guesses.all? {|guess| guess.guess_made?()} or @guesses.any?{|guess| guess.get_guess() == @code.get_code()}
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
    puts()
    display_feedbacks()
    if @feedbacks[-1] == "...." or @feedbacks[-1] == "----"
      puts("Well done! You got it !")
    else
      puts("Better luck next time!")
    end
  end

  def play_computer_guessing()
    puts("Create your code!")
    @code = Code.new(gets.chomp)
    until @guesses.all? {|guess| guess.guess_made?()} or @guesses.any?{|guess| guess.get_guess() == @code.get_code()}
      puts()
      display_feedbacks()
      #find first unmade guess
      unmade_guess = @guesses.find{|guess| not guess.guess_made?()}
      unmade_guess.make_guess(generate_guess())
      index = @feedbacks.find_index{|feedback| feedback == "----"}
      @feedbacks[index] = guess_feedback(unmade_guess, @code)
    end
    puts()
    display_feedbacks()
    if @feedbacks[-1] == "...." or @feedbacks[-1] == "----"
      puts("The computer guessed it!")
    else
      puts("Well done! You stumped the computer!")
    end
  end

  def menu()
    puts("Do you want to:\n1 - Guess the code\n2 - make the code?")
    choice = gets.chomp
    until choice == "1" or choice == "2"
      choice = gets.chomp
    end
    if choice == "1"
      play_human_guessing()
    else
      play_computer_guessing()
    end
  end
end