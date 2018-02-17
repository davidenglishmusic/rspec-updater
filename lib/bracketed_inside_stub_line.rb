require_relative 'bracketed_line'
require_relative 'stub_line'

class BracketedInsideStubLine < BracketedLine
  PATTERN = /{(?:\s*\|.*?\|\s*|\s*)(.+?.stub.+?)\s*}/

  def updated
    unbracketed_code = bracketed_fragment(PATTERN)
    @code.gsub(unbracketed_code, StubLine.new(extract_fragment(@code, unbracketed_code)).updated)
  end
end
