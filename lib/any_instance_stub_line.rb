require_relative 'line'

class AnyInstanceStubLine < Line
  PATTERN = /\.any_instance.stub(\.|\ |\()/

  def updated
    fragment = extract_fragment(@code, /(.*?).any_instance.stub/)
    @code.gsub(fragment + '.any_instance.stub', "allow_any_instance_of(#{fragment}).to receive")
  end
end
