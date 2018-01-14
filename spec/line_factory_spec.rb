require 'line_factory'

RSpec.describe LineFactory, '#from' do
  it 'returns an unchanged line when no changes are necessary' do
    expect(LineFactory.from("puts 'Hello World'").updated)
      .to eql "puts 'Hello World'"
  end

  it 'returns the line when it is a comment' do
    expect(LineFactory.from('  # this is a comment with .should in it').updated)
      .to eql '  # this is a comment with .should in it'
  end
end
