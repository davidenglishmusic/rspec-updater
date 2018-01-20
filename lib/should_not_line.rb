require_relative 'line'

class ShouldNotLine < Line
  def updated
    fragment = extract_fragment(@code, /(.*?).should_not /)
    @code.gsub(fragment + '.should_not', "expect(#{fragment}).not_to")
  end
end
