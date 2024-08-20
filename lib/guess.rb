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

  def make_guess()
    puts("Enter guess >>")
    guess_input = gets.chomp
    until validate(guess_input)
      puts("Enter a guess of four numbers between 1 and 6 >>")
      guess_input = gets.chomp
    end
    @code = guess_input
    @guess_made = true
  end

  def get_guess()
    return @code
  end
end