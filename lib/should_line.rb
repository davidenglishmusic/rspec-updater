require_relative 'line'

class ShouldLine < Line
  def updated
    fragment = extract_fragment(@code, /(.*?).should /)
    update_equality_comparison(@code.gsub(fragment + '.should', "expect(#{fragment}).to"))
  end

  private

  def update_equality_comparison(line)
    line.include?(' == ') ? line.gsub!(' == ', ' eql ') : line
  end
end
