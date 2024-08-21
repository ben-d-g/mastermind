# frozen_string_literal: true

class Guess
  def initialize
    @code = '----'
    @guess_made = false
  end

  def validate(guess_input)
    if guess_input.split('').all { |char| %w[1 2 3 4 5 6].includes?(char) } && (guess_input.length == 4)
      true
    else
      false
    end
  end

  def make_guess(guess_input)
    @code = guess_input
    @guess_made = true
  end

  def get_guess
    @code
  end

  def guess_made?
    @guess_made
  end
end
