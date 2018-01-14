require 'should_line'

RSpec.describe ShouldLine, '#updated' do
  it 'updates an any_instance should_receive line' do
    expect(ShouldLine.new('FakeClass.any_instance.should_receive(:method).and_return(:true)').updated)
      .to eql('expect_any_instance_of(FakeClass).to receive(:method).and_return(:true)')
  end

  it 'updates a should_not_receive line' do
    expect(ShouldLine.new('FakeClass.should_not_receive(:method).and_return(:true)').updated)
      .to eql('expect(FakeClass).not_to receive(:method).and_return(:true)')
  end

  it 'updates a should_receive line' do
    expect(ShouldLine.new('FakeClass.should_receive(:method).and_return(:true)').updated)
      .to eql('expect(FakeClass).to receive(:method).and_return(:true)')
  end

  it 'updates a should_not line' do
    expect(ShouldLine.new('fake_result.should_not eql 1').updated)
      .to eql('expect(fake_result).not_to eql 1')
  end

  it 'updates a should line' do
    expect(ShouldLine.new('fake_result.should eql 6').updated)
      .to eql('expect(fake_result).to eql 6')
  end

  it 'updates a line with spaces at the beginning' do
    expect(ShouldLine.new('  fake_result.should eql 6').updated)
      .to eql('  expect(fake_result).to eql 6')
  end

  it 'updates a line with tabs at the beginning' do
    expect(ShouldLine.new("\t\tfake_result.should eql 6").updated)
      .to eql("\t\texpect(fake_result).to eql 6")
  end
end
