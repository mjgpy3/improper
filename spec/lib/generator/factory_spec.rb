require './lib/generator/factory.rb'

shared_examples 'a generator factory creation method' do |created_generator_klass|
  {
    a: 1,
    an: 1,
    5 => 5,
    20 => 20
  }.each do |q, expected_quantity|
    context "and the factory has been given a quantity of #{q.inspect}" do
      let(:quantity) { q }
      it { is_expected.to be_kind_of(created_generator_klass) }

      it "should pass down the quantity as #{expected_quantity}" do
        expect(created_generator_klass).to receive(:new).with(expected_quantity)
        subject
      end
    end
  end
end


describe Generator::Factory do
  let(:generator) { described_class.new(quantity) }

  {
    'numbers' => Generator::Integer,
    'number' => Generator::Integer,
    'string' => Generator::String,
    'strings' => Generator::String,
  }.each do |method_name, expected_generator|
    describe "##{method_name}" do
      subject { generator.send(method_name) }

      it_behaves_like 'a generator factory creation method', expected_generator
    end
  end
end
