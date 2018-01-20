require_relative 'line'

class BracketedItShouldNotLine < Line
  def updated
    @code.gsub('{ should_not', '{ is_expected.not_to')
  end
end
