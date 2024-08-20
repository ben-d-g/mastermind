class Code
  def initialize()
    @code = generate()
  end

  def generate()
    chars = ["1", "2", "3", "4", "5", "6"]
    randomString = ""
    1.upto(4){randomString += chars.sample}
    return randomString
  end

  def get_code()
    return @code
  end
end