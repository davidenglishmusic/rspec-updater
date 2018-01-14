require_relative 'line'

class BracketedLine < Line
  def updated
    case @code
    when /{ should_not /
      @code.gsub('{ should_not', '{ is_expected.not_to')
    when /{ should /
      @code.gsub('{ should', '{ is_expected.to')
    else
      @code
    end
  end
end
