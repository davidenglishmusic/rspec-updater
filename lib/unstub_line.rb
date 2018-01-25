require_relative 'line'

class UnstubLine < Line
  def updated
    fragment = extract_fragment(@code, /(.*?).unstub/)
    @code.gsub(fragment + '.unstub', "allow(#{fragment}).to receive") + '.and_call_original'
  end
end
