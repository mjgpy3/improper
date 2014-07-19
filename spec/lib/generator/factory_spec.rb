require './lib/generator/factory.rb'

shared_examples 'a numeric generator factory' do
  [
    [[], 'no type', Generator::Integer],
    [[Fixnum], 'a Fixnum', Generator::Integer],
  ].each do |params, type, expected_generator|
    context "when told to generate #{type}" do
      specify { expect(generator.number(*params)).to be_kind_of(expected_generator) }

      it 'should pass down the quantity' do
        expect(expected_generator).to receive(:new).with(:a)
        subject
      end
    end
  end
end


describe Generator::Factory do
  let(:generator) { described_class.new(:a) }

  describe '#numbers' do
    subject { generator.numbers }

    it_behaves_like 'a numeric generator factory'
  end

  describe '#number' do
    subject { generator.number }

    it_behaves_like 'a numeric generator factory'
  end
end
