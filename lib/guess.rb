class Guess
  def initialize()
    @code = "----"
    @guess_made = false
  end

  def validate(guess_input)
    if guess_input.split("").all{|char| ["1", "2", "3", "4", "5", "6"].includes?(char)} and guess_input.length == 4
      return true
    else
      return false
    end
  end

  def make_guess(guess_input)
    @code = guess_input
    @guess_made = true
  end

  def get_guess()
    return @code
  end

  def guess_made?()
    return @guess_made
  end
end