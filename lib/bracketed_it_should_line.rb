require_relative 'line'

class BracketedItShouldLine < Line
  def updated
    @code.gsub('{ should', '{ is_expected.to')
  end
end
