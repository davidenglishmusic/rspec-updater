require_relative 'line'
require_relative 'bracketed_line'
require_relative 'stub_line'
require_relative 'should_line'

class LineFactory
  def self.from(code)
    return Line.new(code) if code.lstrip[0] == '#'
    return BracketedLine.new(code) if code.include?('{')
    return StubLine.new(code) if code.include?('.stub')
    return ShouldLine.new(code) if code.include?('.should')
    Line.new(code)
  end
end
