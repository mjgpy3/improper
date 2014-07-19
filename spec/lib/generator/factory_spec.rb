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

  describe '#numbers' do
    subject { generator.numbers }

    it_behaves_like 'a generator factory creation method', Generator::Integer
  end

  describe '#number' do
    subject { generator.number }

    it_behaves_like 'a generator factory creation method', Generator::Integer
  end

  describe '#string' do
    subject { generator.string }

    it_behaves_like 'a generator factory creation method', Generator::String
  end
end
