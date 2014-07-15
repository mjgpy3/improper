require './spec/spec_helper.rb'
require './lib/improper.rb'

describe '#generating' do
  let(:generator) { generating(quantity) }

  context 'when singular' do
    let(:quantity) { :a }

    describe '#number' do
      subject { generator.number }

      it { is_expected.to be_a(Fixnum) }

      [Fixnum, Float].each do |type|
        context "when told to generate a #{type}" do
          subject { generator.number(type) }

          it { is_expected.to be_a(type) }
        end
      end
    end
  end
end
