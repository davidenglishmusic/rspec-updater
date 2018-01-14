class Line
  attr_accessor :code

  def initialize(code)
    @code = code
  end

  def updated
    @code
  end

  private

  def extract_fragment(line, regex)
    line.lstrip.scan(regex).flatten.first
  end
end
