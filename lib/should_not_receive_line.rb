require_relative 'line'

class ShouldNotReceiveLine < Line
  PATTERN = /(.*?)\.should_not_receive(\.|\ |\()/

  def updated
    fragment = extract_fragment(@code, PATTERN)
    @code.gsub(fragment + '.should_not_receive', "expect(#{fragment}).not_to receive")
  end
end
