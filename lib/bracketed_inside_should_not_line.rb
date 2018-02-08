require_relative 'bracketed_line'
require_relative 'should_not_line'

class BracketedInsideShouldNotLine < BracketedLine
  PATTERN = /{\s*\|\S+\|\s*(.+?.should_not.+?)\s*}/

  def updated
    unbracketed_code = bracketed_fragment(PATTERN)
    @code.gsub(unbracketed_code, ShouldNotLine.new(extract_fragment(@code, unbracketed_code)).updated)
  end
end
