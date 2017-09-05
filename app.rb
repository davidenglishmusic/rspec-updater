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
                 when /.should_receive/
                   fragment = line.split("\t")[-1].scan(/(.*?).should_receive/).flatten.first
                   line.gsub(fragment + '.should_receive', "expect(#{fragment}).to receive")
                 when /.should_not /
                   fragment = line.split("\t")[-1].scan(/(.*?).should /).flatten.first
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
  when /.stub\(/
    fragment = line.split("\t")[-1].scan(/(.*?).stub/).flatten.first
    line.gsub(fragment + '.stub', "allow(#{fragment}).to receive")
  else line
  end
end

path = ARGV.first
line_index = 1

lines = IO.readlines(path).map do |line|
  old_line = line
  updated_line = line
  if line.include?('{ should')
    updated_line = replace_bracketed_should(line)
  elsif line.include?('.should')
    updated_line = replace_should(line)
  elsif line.include?('.stub')
    updated_line = replace_stub(line)
  end

  if old_line != updated_line
    puts "Replacing #{line_index}"
    puts "old: #{old_line}"
    puts "new: #{updated_line}"
  end
  line_index += 1

  old_line != updated_line ? updated_line : old_line
end

File.open(path, 'w') do |file|
  file.puts lines
end
