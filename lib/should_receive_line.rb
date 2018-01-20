require_relative 'line'

class ShouldReceiveLine < Line
  def updated
    fragment = extract_fragment(@code, /(.*?).should_receive/)
    @code.gsub(fragment + '.should_receive', "expect(#{fragment}).to receive")
  end
end
