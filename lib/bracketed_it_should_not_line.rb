require_relative 'bracketed_line'

class BracketedItShouldNotLine < BracketedLine
  PATTERN = /{\s*(should_not)/

  def updated
    @code.gsub(bracketed_fragment(PATTERN), 'is_expected.not_to')
  end
end
