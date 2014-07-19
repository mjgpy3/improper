require './lib/generator/factory.rb'

describe Generator::Factory do
  let(:generator) { described_class.new(:a) }

  describe '#number' do
    subject { generator.number }

    context 'when not given a type to generate' do
      specify { expect(generator.number).to be_kind_of(Generator::Integer) }

      it 'should pass down the quantity' do
        expect(Generator::Integer).to receive(:new).with(:a)
        subject
      end
    end

    context 'when told to generate a Fixnum' do
      specify { expect(generator.number(Fixnum)).to be_kind_of(Generator::Integer) }

      it 'should pass down the quantity' do
        expect(Generator::Integer).to receive(:new).with(:a)
        subject
      end
    end
  end
end
