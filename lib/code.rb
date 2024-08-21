# frozen_string_literal: true

class Code
  def initialize(code = '')
    @code = generate(code)
  end

  def generate(code)
    return code unless code == ''

    chars = %w[1 2 3 4 5 6]
    randomString = ''
    1.upto(4) { randomString += chars.sample }
    randomString
  end

  def get_code
    @code
  end
end
