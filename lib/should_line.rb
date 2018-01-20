require_relative 'line'

class ShouldLine < Line
  def updated
    fragment = extract_fragment(@code, /(.*?).should /)
    @code.gsub(fragment + '.should', "expect(#{fragment}).to")
  end
end
