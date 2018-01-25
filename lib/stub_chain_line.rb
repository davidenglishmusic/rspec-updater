require_relative 'line'

class StubChainLine < Line
  PATTERN = /(.*?)\.stub_chain(\.|\ |\()/

  def updated
    fragment = extract_fragment(@code, PATTERN)
    @code.gsub(fragment + '.stub_chain', "allow(#{fragment}).to receive_message_chain")
  end
end
