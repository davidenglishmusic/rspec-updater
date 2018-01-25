require_relative 'line'

class AnyInstanceShouldReceiveLine < Line
  PATTERN = /\.any_instance.should_receive(\.|\ |\()/

  def updated
    fragment = extract_fragment(@code, /(.*?).any_instance.should_receive/)
    @code.gsub(fragment + '.any_instance.should_receive', "expect_any_instance_of(#{fragment}).to receive")
  end
end
