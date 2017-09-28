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
    updated_line = case line
                   when /.any_instance.should_receive/
                     fragment = line.split("\t")[-1].scan(/(.*?).any_instance.should_receive/).flatten.first
                     line.gsub(fragment + '.any_instance.should_receive', "expect_any_instance_of(#{fragment}).to receive")
                   when /.should_receive/
                     fragment = line.split("\t")[-1].scan(/(.*?).should_receive/).flatten.first
                     line.gsub(fragment + '.should_receive', "expect(#{fragment}).to receive")
                   when /.should_not /
                     fragment = line.split("\t")[-1].scan(/(.*?).should_not /).flatten.first
                     line.gsub(fragment + '.should_not', "expect(#{fragment}).not_to")
                   when /.should /
                     fragment = line.split("\t")[-1].scan(/(.*?).should /).flatten.first
                     line.gsub(fragment + '.should', "expect(#{fragment}).to")
                   else line
                   end
    updated_line.include?(' == ') ? updated_line.gsub!(' == ', ' eql ') : updated_line
  end

  def replace_stub(line)
    case line
    when /.stub_chain/
      fragment = line.split("\t")[-1].scan(/(.*?).stub_chain\(/).flatten.first
      line.gsub(fragment + '.stub_chain', "allow(#{fragment}).to receive_message_chain")
    when /.any_instance.stub\(/
      fragment = line.split("\t")[-1].scan(/(.*?).any_instance.stub/).flatten.first
      line.gsub(fragment + '.any_instance.stub', "allow_any_instance_of(#{fragment}).to receive")
    when /.stub\(/
      fragment = line.split("\t")[-1].scan(/(.*?).stub/).flatten.first
      line.gsub(fragment + '.stub', "allow(#{fragment}).to receive")
    else line
    end
  end
end
