class Code
  def initialize(code = "")
    @code = generate(code)
  end

  def generate(code)
    if code == ""
      chars = ["1", "2", "3", "4", "5", "6"]
      randomString = ""
      1.upto(4){randomString += chars.sample}
      return randomString
    else
      return code
    end
    
  end

  def get_code()
    return @code
  end
end