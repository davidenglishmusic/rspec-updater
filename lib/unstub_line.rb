require_relative 'line'

class UnstubLine < Line
  PATTERN = /(.*?)\.unstub(\.|\ |\()/

  def updated
    fragment = extract_fragment(@code, PATTERN)
    @code.gsub(fragment + '.unstub', "allow(#{fragment}).to receive") + '.and_call_original'
  end
end
