require_relative 'line'

class ShouldLine < Line
  def updated
    updated_line =
      case @code
      when /.any_instance.should_receive/
        fragment = extract_fragment(@code, /(.*?).any_instance.should_receive/)
        @code.gsub(fragment + '.any_instance.should_receive', "expect_any_instance_of(#{fragment}).to receive")
      when /.should_not_receive/
        fragment = extract_fragment(@code, /(.*?).should_not_receive/)
        @code.gsub(fragment + '.should_not_receive', "expect(#{fragment}).not_to receive")
      when /.should_receive/
        fragment = extract_fragment(@code, /(.*?).should_receive/)
        @code.gsub(fragment + '.should_receive', "expect(#{fragment}).to receive")
      when /.should_not /
        fragment = extract_fragment(@code, /(.*?).should_not /)
        @code.gsub(fragment + '.should_not', "expect(#{fragment}).not_to")
      when /.should /
        fragment = extract_fragment(@code, /(.*?).should /)
        @code.gsub(fragment + '.should', "expect(#{fragment}).to")
      else
        @code
      end
    update_equality_comparison(updated_line)
  end

  private

  def update_equality_comparison(line)
    line.include?(' == ') ? line.gsub!(' == ', ' eql ') : line
  end
end
