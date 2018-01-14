require_relative 'line'
require_relative 'should_line'

class BracketedLine < Line
  def updated
    case @code
    when /{ should_not /
      @code.gsub('{ should_not', '{ is_expected.not_to')
    when /{ should /
      @code.gsub('{ should', '{ is_expected.to')
    when /{(.+?.stub.+?)}/
      @code.gsub(/{(.+?.stub.+?)}/, '{' + StubLine.new(extract_fragment(@code, /{(.+?.stub.+?)}/)).updated + '}')
    when /{(.+?.should.+?)}/
      @code.gsub(/{(.+?.should.+?)}/, '{' + ShouldLine.new(extract_fragment(@code, /{(.+?.should.+?)}/)).updated + '}')
    when /stub/
      StubLine.new(@code).updated
    else
      ShouldLine.new(@code).updated
    end
  end
end
