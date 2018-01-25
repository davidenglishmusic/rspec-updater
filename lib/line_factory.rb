require_relative 'line'
require_relative 'stub_line'
require_relative 'unstub_line'
require_relative 'should_line'
require_relative 'bracketed_inside_should_not_line'
require_relative 'bracketed_inside_should_line'
require_relative 'bracketed_it_should_line'
require_relative 'bracketed_it_should_not_line'
require_relative 'bracketed_inside_stub_line'
require_relative 'bracketed_inside_unstub_line'
require_relative 'stub_chain_line'
require_relative 'any_instance_stub_line'
require_relative 'any_instance_should_receive_line'
require_relative 'should_not_receive_line'
require_relative 'should_receive_line'
require_relative 'should_not_line'

class LineFactory
  def self.from(code)
    case code
    when /^\s*#/
      Line.new(code)
    when BracketedItShouldNotLine::PATTERN
      BracketedItShouldNotLine.new(code)
    when BracketedItShouldLine::PATTERN
      BracketedItShouldLine.new(code)
    when BracketedInsideShouldLine::PATTERN
      BracketedInsideShouldLine.new(code)
    when BracketedInsideShouldNotLine::PATTERN
      BracketedInsideShouldNotLine.new(code)
    when BracketedInsideUnstubLine::PATTERN
      BracketedInsideUnstubLine.new(code)
    when BracketedInsideStubLine::PATTERN
      BracketedInsideStubLine.new(code)
    when StubChainLine::PATTERN
      StubChainLine.new(code)
    when AnyInstanceStubLine::PATTERN
      AnyInstanceStubLine.new(code)
    when UnstubLine::PATTERN
      UnstubLine.new(code)
    when StubLine::PATTERN
      StubLine.new(code)
    when AnyInstanceShouldReceiveLine::PATTERN
      AnyInstanceShouldReceiveLine.new(code)
    when ShouldNotReceiveLine::PATTERN
      ShouldNotReceiveLine.new(code)
    when ShouldReceiveLine::PATTERN
      ShouldReceiveLine.new(code)
    when ShouldNotLine::PATTERN
      ShouldNotLine.new(code)
    when ShouldLine::PATTERN
      ShouldLine.new(code)
    else
      Line.new(code)
    end
  end
end
