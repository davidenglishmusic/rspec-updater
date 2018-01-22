require 'line_factory'

RSpec.describe Line, '#updated' do
  it 'returns an unchanged line when no changes are needed' do
    no_changes_needed_line = LineFactory.from("puts 'Hello World'")
    expect(no_changes_needed_line.updated).to eql "puts 'Hello World'"
  end

  it 'returns an unchanged line when should is mentioned but is not a method call' do
    no_changes_needed_line = LineFactory.from('def my_method(should_parameter)')
    expect(no_changes_needed_line.updated).to eql 'def my_method(should_parameter)'
  end

  it 'returns the line when it is a comment' do
    commented_out_line = LineFactory.from('  # this is a comment with .should in it')
    expect(commented_out_line.updated)
      .to eql '  # this is a comment with .should in it'
  end

  it 'updates a bracketed it should_not line' do
    bracketed_it_should_not_line = LineFactory.from('it { should_not eql 5 }')
    expect(bracketed_it_should_not_line.updated)
      .to eql 'it { is_expected.not_to eql 5 }'
  end

  it 'updates a bracketed it should line' do
    bracketed_it_should_line = LineFactory.from('it { should eql 2 }')
    expect(bracketed_it_should_line.updated)
      .to eql 'it { is_expected.to eql 2 }'
  end

  it 'updates a line with should outside of the brackets' do
    should_outside_brackets_line = LineFactory.from('-> { get :show }.should raise_error(StandardError)')
    expect(should_outside_brackets_line.updated)
      .to eql 'expect(-> { get :show }).to raise_error(StandardError)'
  end

  it 'updates a line with should not outside of the brackets' do
    should_not_outside_brackets_line = LineFactory.from('-> { get :update }.should_not raise_error(StandardError)')
    expect(should_not_outside_brackets_line.updated)
      .to eql 'expect(-> { get :update }).not_to raise_error(StandardError)'
  end

  it 'updates a line with stub outside of the brackets' do
    stub_outside_brackets_line = LineFactory.from('-> { get :show }.stub("current_person").and_return(person)')
    expect(stub_outside_brackets_line.updated)
      .to eql 'allow(-> { get :show }).to receive("current_person").and_return(person)'
  end

  it 'updates a bracketed line with a stub expression inside the brackets' do
    stub_inside_brackets_line = LineFactory.from('before(:each) { @controller.stub(:current_person).and_return(person) }')
    expect(stub_inside_brackets_line.updated)
      .to eql('before(:each) { allow(@controller).to receive(:current_person).and_return(person) }')
  end

  it 'updates a stub_chain line' do
    stub_chain_line = LineFactory.from('FakeClass.stub_chain(:message_a, :message_b)')
    expect(stub_chain_line.updated)
      .to eql('allow(FakeClass).to receive_message_chain(:message_a, :message_b)')
  end

  it 'updates an any_instance.stub line' do
    any_instance_stub_line = LineFactory.from('FakeClass.any_instance.stub(:fake_method)')
    expect(any_instance_stub_line.updated)
      .to eql('allow_any_instance_of(FakeClass).to receive(:fake_method)')
  end

  it 'updates a stub line' do
    stub_line = LineFactory.from('FakeClass.stub(:fake_method)')
    expect(stub_line.updated).to eql('allow(FakeClass).to receive(:fake_method)')
  end

  it 'updates an any_instance should_receive line' do
    any_instance_should_receive_line = LineFactory.from('FakeClass.any_instance.should_receive(:method).and_return(:true)')
    expect(any_instance_should_receive_line.updated)
      .to eql('expect_any_instance_of(FakeClass).to receive(:method).and_return(:true)')
  end

  it 'updates a should_not_receive line' do
    should_not_receive_line = LineFactory.from('FakeClass.should_not_receive(:method).and_return(:true)')
    expect(should_not_receive_line.updated)
      .to eql('expect(FakeClass).not_to receive(:method).and_return(:true)')
  end

  it 'updates a should_receive line' do
    should_receive_line = LineFactory.from('FakeClass.should_receive(:method).and_return(:true)')
    expect(should_receive_line.updated)
      .to eql('expect(FakeClass).to receive(:method).and_return(:true)')
  end

  it 'updates a should_not line' do
    should_not_line = LineFactory.from('fake_result.should_not eql 1')
    expect(should_not_line.updated).to eql('expect(fake_result).not_to eql 1')
  end

  it 'updates a should line' do
    should_line = LineFactory.from('fake_result.should eql 6')
    expect(should_line.updated).to eql('expect(fake_result).to eql 6')
  end

  it 'updates a line with spaces at the beginning' do
    should_line_starting_with_spaces = LineFactory.from('  fake_result.should eql 6')
    expect(should_line_starting_with_spaces.updated).to eql('  expect(fake_result).to eql 6')
  end

  it 'updates a line with tabs at the beginning' do
    should_line_with_tabs = LineFactory.from("\t\tfake_result.should eql 6")
    expect(should_line_with_tabs.updated).to eql("\t\texpect(fake_result).to eql 6")
  end
end
