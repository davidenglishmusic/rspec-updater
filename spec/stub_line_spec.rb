require 'stub_line'

RSpec.describe StubLine, '#updated' do
  it 'updates a stub_chain line' do
    expect(StubLine.new('FakeClass.stub_chain(:message_a, :message_b)').updated)
      .to eql('allow(FakeClass).to receive_message_chain(:message_a, :message_b)')
  end

  it 'updates an any_instance.stub line' do
    expect(StubLine.new('FakeClass.any_instance.stub(:fake_method)').updated)
      .to eql('allow_any_instance_of(FakeClass).to receive(:fake_method)')
  end

  it 'updates a stub line' do
    expect(StubLine.new('FakeClass.stub(:fake_method)').updated)
      .to eql('allow(FakeClass).to receive(:fake_method)')
  end
end
