require './lib/generator/factory.rb'

describe Generator::Factory do
  let(:generator) { described_class.new(:a) }

  describe '#number' do
    subject { generator.number }

    {
      [] => 'no type',
      [Fixnum] => 'a Fixnum'
    }.each do |params, type|
      context "when told to generate #{type}" do
        specify { expect(generator.number(*params)).to be_kind_of(Generator::Integer) }

        it 'should pass down the quantity' do
          expect(Generator::Integer).to receive(:new).with(:a)
          subject
        end
      end
    end
  end
end
