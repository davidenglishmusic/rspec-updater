require_relative 'bracketed_line'
require_relative 'should_line'

class BracketedInsideShouldNotLine < BracketedLine
  PATTERN = /{\s*should_not(\.|\ |\()/

  def updated
    unbracketed_code = bracketed_fragment(PATTERN)
    @code.gsub(unbracketed_code, ShouldLine.new(extract_fragment(@code, unbracketed_code)).updated)
  end
end
