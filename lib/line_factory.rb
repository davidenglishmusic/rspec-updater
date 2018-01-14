require_relative 'line'
require_relative 'bracketed_line'
require_relative 'should_line'
require_relative 'stub_line'

class LineFactory
  def self.from(code)
    return Line.new(code) if code.lstrip[0] == '#'
    return BracketedLine.new(code) if code.include?('{')
    return ShouldLine.new(code) if code.include?('.should')
    return StubLine.new(code) if code.include?('.stub')
    Line.new(code)
  end
end
