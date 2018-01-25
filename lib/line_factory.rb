require_relative 'comment_line'
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

LINE_TYPES = [
  CommentLine,
  BracketedItShouldNotLine,
  BracketedItShouldLine,
  BracketedInsideShouldNotLine,
  BracketedInsideShouldLine,
  BracketedInsideUnstubLine,
  BracketedInsideStubLine,
  StubChainLine,
  AnyInstanceStubLine,
  UnstubLine,
  StubLine,
  AnyInstanceShouldReceiveLine,
  ShouldNotReceiveLine,
  ShouldReceiveLine,
  ShouldNotLine,
  ShouldLine
].freeze

class LineFactory
  def self.from(code)
    LINE_TYPES.each do |line_type|
      return line_type.new(code) if code[line_type::PATTERN]
    end
    Line.new(code)
  end
end
