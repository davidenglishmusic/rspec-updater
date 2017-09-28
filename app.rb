require './lib/updater'

path = ARGV.first
line_index = 1
@updater = Updater.new

lines = IO.readlines(path).map do |line|
  old_line = line
  updated_line = @updater.update_line(old_line)

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
