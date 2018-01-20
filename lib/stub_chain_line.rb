require_relative 'line'

class StubChainLine < Line
  def updated
    fragment = extract_fragment(@code, /(.*?).stub_chain\(/)
    @code.gsub(fragment + '.stub_chain', "allow(#{fragment}).to receive_message_chain")
  end
end
