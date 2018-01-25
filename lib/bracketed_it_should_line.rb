require_relative 'bracketed_line'

class BracketedItShouldLine < BracketedLine
  PATTERN = /{\s*(should)/

  def updated
    @code.gsub(bracketed_fragment(PATTERN), 'is_expected.to')
  end
end
