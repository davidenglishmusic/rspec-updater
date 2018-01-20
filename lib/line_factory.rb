require_relative 'line'
require_relative 'stub_line'
require_relative 'should_line'
require_relative 'bracketed_inside_should_not_line'
require_relative 'bracketed_inside_should_line'
require_relative 'bracketed_it_should_line'
require_relative 'bracketed_it_should_not_line'
require_relative 'bracketed_inside_stub_line'
require_relative 'stub_chain_line'
require_relative 'any_instance_stub_line'
require_relative 'any_instance_should_receive_line'
require_relative 'should_not_receive_line'
require_relative 'should_receive_line'
require_relative 'should_not_line'

class LineFactory
  def self.from(code)
    case code
    when /\s+#/
      Line.new(code)
    when /{ should_not /
      BracketedItShouldNotLine.new(code)
    when /{ should /
      BracketedItShouldLine.new(code)
    when /{(.+?.should.+?)}/
      BracketedInsideShouldLine.new(code)
    when /{(.+?.should_not.+?)}/
      BracketedInsideShouldNotLine.new(code)
    when /{(.+?.stub.+?)}/
      BracketedInsideStubLine.new(code)
    when /.stub_chain/
      StubChainLine.new(code)
    when /.any_instance.stub\(/
      AnyInstanceStubLine.new(code)
    when /.stub/
      StubLine.new(code)
    when /.any_instance.should_receive/
      AnyInstanceShouldReceiveLine.new(code)
    when /.should_not_receive/
      ShouldNotReceiveLine.new(code)
    when /.should_receive/
      ShouldReceiveLine.new(code)
    when /.should_not/
      ShouldNotLine.new(code)
    when /.should/
      ShouldLine.new(code)
    else
      Line.new(code)
    end
  end
end
