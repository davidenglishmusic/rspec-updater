require_relative 'line'

class StubLine < Line
  def updated
    fragment = extract_fragment(@code, /(.*?).stub/)
    @code.gsub(fragment + '.stub', "allow(#{fragment}).to receive")
  end
end
