require_relative 'line'

class StubLine < Line
  def updated
    case @code
    when /.stub_chain/
      fragment = extract_fragment(@code, /(.*?).stub_chain\(/)
      @code.gsub(fragment + '.stub_chain', "allow(#{fragment}).to receive_message_chain")
    when /.any_instance.stub\(/
      fragment = extract_fragment(@code, /(.*?).any_instance.stub/)
      @code.gsub(fragment + '.any_instance.stub', "allow_any_instance_of(#{fragment}).to receive")
    when /.stub\(/
      fragment = extract_fragment(@code, /(.*?).stub/)
      @code.gsub(fragment + '.stub', "allow(#{fragment}).to receive")
    else
      @code
    end
  end
end
