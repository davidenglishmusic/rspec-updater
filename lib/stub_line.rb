require_relative 'line'

class StubLine < Line
  PATTERN = /(.*?)\.stub(\.|\ |\()/

  def updated
    fragment = extract_fragment(@code, PATTERN)
    @code.gsub(fragment + '.stub', "allow(#{fragment}).to receive")
  end
end
