require 'updater'

RSpec.describe Updater, '#update_line' do
  before(:all) do
    @updater = Updater.new
  end

  it 'returns an unchanged line when no changes are necessary' do
    expect(@updater.update_line("puts 'Hello World'")).to eql "puts 'Hello World'"
  end

  it 'returns the line when it is a comment' do
    expect(@updater.update_line('  # this is a comment with .should in it'))
      .to eql '  # this is a comment with .should in it'
  end

  it 'updates a bracketed should line' do
    expect(@updater.update_line('it { should eql 5 }')).to eql 'it { is_expected.to eql 5 }'
  end

  it 'updates a bracketed should not line' do
    expect(@updater.update_line('it { should_not eql 2 }')).to eql 'it { is_expected.not_to eql 2 }'
  end

  it 'updates a bracketed should not line' do
    expect(@updater.update_line('it { should_not eql 2 }')).to eql 'it { is_expected.not_to eql 2 }'
  end

  it 'updates an any_instance should_receive line' do
    expect(@updater.update_line('FakeClass.any_instance.should_receive(:method).and_return(:true)'))
      .to eql('expect_any_instance_of(FakeClass).to receive(:method).and_return(:true)')
  end

  it 'updates a should_receive line' do
    expect(@updater.update_line('FakeClass.should_receive(:method).and_return(:true)'))
      .to eql('expect(FakeClass).to receive(:method).and_return(:true)')
  end

  it 'updates a should_not line' do
    expect(@updater.update_line('fake_result.should_not eql 1'))
      .to eql('expect(fake_result).not_to eql 1')
  end

  it 'updates a should line' do
    expect(@updater.update_line('fake_result.should eql 6'))
      .to eql('expect(fake_result).to eql 6')
  end

  it 'updates a stub_chain line' do
    expect(@updater.update_line('FakeClass.stub_chain(:message_a, :message_b)'))
      .to eql('allow(FakeClass).to receive_message_chain(:message_a, :message_b)')
  end

  it 'updates an any_instance.stub line' do
    expect(@updater.update_line('FakeClass.any_instance.stub(:fake_method)'))
      .to eql('allow_any_instance_of(FakeClass).to receive(:fake_method)')
  end

  it 'updates a stub line' do
    expect(@updater.update_line('FakeClass.stub(:fake_method)'))
      .to eql('allow(FakeClass).to receive(:fake_method)')
  end
end
