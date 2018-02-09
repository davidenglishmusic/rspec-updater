require_relative 'bracketed_line'
require_relative 'unstub_line'

class BracketedInsideUnstubLine < BracketedLine
  PATTERN = /{(?:\s*\|\S+\|\s*|\s*)(.+?.unstub.+?)\s*}/

  def updated
    unbracketed_code = bracketed_fragment(PATTERN)
    @code.gsub(unbracketed_code, UnstubLine.new(extract_fragment(@code, unbracketed_code)).updated)
  end
end
