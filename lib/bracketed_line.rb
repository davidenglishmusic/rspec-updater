require_relative 'line'

class BracketedLine < Line
  private

  def bracketed_fragment(fragment_regex)
    @code.match(fragment_regex)[1]
  end
end
