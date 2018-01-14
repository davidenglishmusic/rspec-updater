require 'bracketed_line'

RSpec.describe BracketedLine, '#updated' do
  it 'updates a bracketed should line' do
    expect(BracketedLine.new('it { should eql 5 }').updated)
      .to eql 'it { is_expected.to eql 5 }'
  end

  it 'updates a bracketed should not line' do
    expect(BracketedLine.new('it { should_not eql 2 }').updated)
      .to eql 'it { is_expected.not_to eql 2 }'
  end
end
