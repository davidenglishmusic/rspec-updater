require_relative 'bracketed_line'
require_relative 'should_line'

class BracketedInsideShouldLine < BracketedLine
  PATTERN = /{(?:\s*\|.*?\|\s*|\s*)(.+?.should.+?)\s*}/

  def updated
    unbracketed_code = bracketed_fragment(PATTERN)
    @code.gsub(unbracketed_code, ShouldLine.new(extract_fragment(@code, unbracketed_code)).updated)
  end
end
