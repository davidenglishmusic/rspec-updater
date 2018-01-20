require_relative 'line'
require_relative 'should_line'

class BracketedInsideShouldLine < Line
  def updated
    @code.gsub(/{(.+?.should.+?)}/, '{' + ShouldLine.new(extract_fragment(@code, /{(.+?.should.+?)}/)).updated + '}')
  end
end
