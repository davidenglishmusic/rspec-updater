require 'bracketed_line'

RSpec.describe BracketedLine, '#updated' do
  it 'updates a line with should inside of the brackets' do
    expect(BracketedLine.new('it { should eql 5 }').updated)
      .to eql 'it { is_expected.to eql 5 }'
  end

  it 'updates a line with should outside of the brackets' do
    expect(BracketedLine.new('-> { get :show }.should raise_error(StandardError)').updated)
      .to eql 'expect(-> { get :show }).to raise_error(StandardError)'
  end

  it 'updates a line with should not inside of the brackets' do
    expect(BracketedLine.new('it { should_not eql 2 }').updated)
      .to eql 'it { is_expected.not_to eql 2 }'
  end

  it 'updates a line with should not outside of the brackets' do
    expect(BracketedLine.new('-> { get :update }.should_not raise_error(StandardError)').updated)
      .to eql 'expect(-> { get :update }).not_to raise_error(StandardError)'
  end
end
