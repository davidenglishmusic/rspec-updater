require_relative 'line'
require_relative 'stub_line'

class BracketedInsideStubLine < Line
  def updated
    @code.gsub(/{(.+?.stub.+?)}/, '{' + StubLine.new(extract_fragment(@code, /{(.+?.stub.+?)}/)).updated + '}')
  end
end
