require_relative 'line'
require_relative 'unstub_line'

class BracketedInsideUnstubLine < Line
  def updated
    unbracketed_code = @code.match(/{\s*(.+?.unstub.+?)\s*}/)[1]
    @code.gsub(unbracketed_code, UnstubLine.new(extract_fragment(@code, unbracketed_code)).updated)
  end
end
