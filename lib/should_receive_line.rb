require_relative 'line'

class ShouldReceiveLine < Line
  PATTERN = /(.*?)\.should_receive(\.|\ |\()/

  def updated
    fragment = extract_fragment(@code, PATTERN)
    @code.gsub(fragment + '.should_receive', "expect(#{fragment}).to receive")
  end
end
