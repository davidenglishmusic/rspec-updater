require_relative 'line'

class ShouldLine < Line
  PATTERN = /(.*?)\.should(\.|\ |\()/

  def updated
    fragment = extract_fragment(@code, PATTERN)
    @code.gsub(fragment + '.should', "expect(#{fragment}).to")
  end
end
