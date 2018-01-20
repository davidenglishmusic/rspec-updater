require_relative 'line'
require_relative 'should_line'

class BracketedInsideShouldNotLine < Line
  def updated
    @code.gsub(/{(.+?.should_not.+?)}/, '{' + ShouldLine.new(extract_fragment(@code, /{(.+?.should_not.+?)}/)).updated + '}')
  end
end
