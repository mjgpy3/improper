require './lib/generator/factory.rb'

describe Generator::Factory do
  let(:generator) { described_class.new(:a) }

  describe '#number' do
    subject { generator.number }

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
end
