require 'pry'

class Updater
  def update_line(line)
    return line if line.lstrip[0] == '#'
    return replace_bracketed_should(line) if line.include?('{ should')
    return replace_should(line) if line.include?('.should')
    return replace_stub(line) if line.include?('.stub')
    line
  end

  private

  def replace_bracketed_should(line)
    case line
    when /{ should_not /
      line.gsub('{ should_not', '{ is_expected.not_to')
    when /{ should /
      line.gsub('{ should', '{ is_expected.to')
    else line
    end
  end

  def replace_should(line)
    updated_line =
      case line
      when /.any_instance.should_receive/
        fragment = extract_fragment(line, /(.*?).any_instance.should_receive/)
        line.gsub(fragment + '.any_instance.should_receive', "expect_any_instance_of(#{fragment}).to receive")
      when /.should_not_receive/
        fragment = extract_fragment(line, /(.*?).should_not_receive/)
        line.gsub(fragment + '.should_not_receive', "expect(#{fragment}).not_to receive")
      when /.should_receive/
        fragment = extract_fragment(line, /(.*?).should_receive/)
        line.gsub(fragment + '.should_receive', "expect(#{fragment}).to receive")
      when /.should_not /
        fragment = extract_fragment(line, /(.*?).should_not /)
        line.gsub(fragment + '.should_not', "expect(#{fragment}).not_to")
      when /.should /
        fragment = extract_fragment(line, /(.*?).should /)
        line.gsub(fragment + '.should', "expect(#{fragment}).to")
      else line
      end
    updated_line.include?(' == ') ? updated_line.gsub!(' == ', ' eql ') : updated_line
  end

  def replace_stub(line)
    case line
    when /.stub_chain/
      fragment = extract_fragment(line, /(.*?).stub_chain\(/)
      line.gsub(fragment + '.stub_chain', "allow(#{fragment}).to receive_message_chain")
    when /.any_instance.stub\(/
      fragment = extract_fragment(line, /(.*?).any_instance.stub/)
      line.gsub(fragment + '.any_instance.stub', "allow_any_instance_of(#{fragment}).to receive")
    when /.stub\(/
      fragment = extract_fragment(line, /(.*?).stub/)
      line.gsub(fragment + '.stub', "allow(#{fragment}).to receive")
    else line
    end
  end

  def extract_fragment(line, regex)
    line.lstrip.scan(regex).flatten.first
  end
end
