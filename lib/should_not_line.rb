require_relative 'line'

class ShouldNotLine < Line
  PATTERN = /(.*?)\.should_not(\.|\ |\()/

  def updated
    fragment = extract_fragment(@code, PATTERN)
    @code.gsub(fragment + '.should_not', "expect(#{fragment}).not_to")
  end
end
