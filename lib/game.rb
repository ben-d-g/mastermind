# frozen_string_literal: true

require_relative('code')
require_relative('guess')

class Game
  def initialize
    @code = Code.new
    @guesses = Array.new(8) { Guess.new }
    @feedbacks = Array.new(8) { '----' }
  end

  def guess_feedback(guess, code)
    feedback = ''
    0.upto(guess.get_guess.length - 1) do |index|
      feedback += if guess.get_guess[index] == code.get_code[index]
                    '.'
                  elsif code.get_code.split('').include?(guess.get_guess[index])
                    '?'
                  else
                    '!'
                  end
    end
    feedback
  end

  def guess_input
    puts('Enter your code >>')
    input = gets.chomp
    until input.split('').all? { |char| %w[1 2 3 4 5 6].include?(char) } && (input.length == 4)
      puts('Your code must be a string of 4 integers between 1 and 6 >>')
      input = gets.chomp
    end
    input
  end

  def generate_guess(turn)
    chars = %w[1 2 3 4 5 6]
    if turn.zero?
      randomString = ''
      1.upto(4) { randomString += chars.sample }
      randomString
    else
      0.upto(7) do |guess_index|
        0.upto(3) do |char_index|
          chars.delete(@guesses[guess_index].get_guess[char_index]) if @feedbacks[guess_index][char_index] == '!'
        end
      end
      guess_string = ''
      0.upto(3) do |index|
        guess_string += if @feedbacks[turn - 1][index] == '.'
                          @guesses[turn - 1].get_guess[index]
                        else
                          chars.sample
                        end
      end
      guess_string
    end
  end

  def display_guesses
    @guesses.each { |guess| puts(guess.get_guess) }
  end

  def display_feedbacks
    @feedbacks.each { |feedback| puts feedback }
  end

  def play_human_guessing
    # game is done when all guesses have been made
    until @guesses.all?(&:guess_made?) || @guesses.any? { |guess| guess.get_guess == @code.get_code }
      puts
      display_feedbacks
      # find first unmade guess
      unmade_guess = @guesses.find { |guess| !guess.guess_made? }
      unmade_guess.make_guess(guess_input)
      # ungiven_feedback = @feedbacks.find{|feedback| feedback == "----"}
      # ungiven_feedback = guess_feedback(unmade_guess, @code)
      index = @feedbacks.find_index { |feedback| feedback == '----' }
      @feedbacks[index] = guess_feedback(unmade_guess, @code)
    end
    puts
    display_feedbacks
    if (@feedbacks[-1] == '....') || (@feedbacks[-1] == '----')
      puts('Well done! You got it !')
    else
      puts('Better luck next time!')
    end
  end

  def play_computer_guessing
    puts('Create your code!')
    @code = Code.new(gets.chomp)
    turn = 0
    until @guesses.all?(&:guess_made?) || @guesses.any? { |guess| guess.get_guess == @code.get_code }
      puts
      display_feedbacks
      # find first unmade guess
      unmade_guess = @guesses.find { |guess| !guess.guess_made? }
      unmade_guess.make_guess(generate_guess(turn))
      index = @feedbacks.find_index { |feedback| feedback == '----' }
      @feedbacks[index] = guess_feedback(unmade_guess, @code)
      turn += 1
    end
    puts
    display_feedbacks
    if (@feedbacks[-1] == '....') || (@feedbacks[-1] == '----')
      puts('The computer guessed it!')
    else
      puts('Well done! You stumped the computer!')
    end
  end

  def menu
    puts("Do you want to:\n1 - Guess the code\n2 - make the code?")
    choice = gets.chomp
    choice = gets.chomp until (choice == '1') || (choice == '2')
    if choice == '1'
      play_human_guessing
    else
      play_computer_guessing
    end
  end
end
