require_relative 'line'

class ShouldNotReceiveLine < Line
  def updated
    fragment = extract_fragment(@code, /(.*?).should_not_receive/)
    @code.gsub(fragment + '.should_not_receive', "expect(#{fragment}).not_to receive")
  end
end
