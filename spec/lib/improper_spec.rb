require './spec/spec_helper.rb'
require './lib/improper.rb'

describe '#generating' do
  let(:generator) { generating(quantity) }

  context 'when singular' do
    let(:quantity) { :a }

    describe '#number' do
      describe '#first' do
        subject { generator.number.first }

        it { is_expected.to be_a(Fixnum) }
      end

      [Fixnum, Float].each do |type|
        context "when told to generate a #{type}" do
          describe '#first' do
            subject { generator.number(type).first }

            it { is_expected.to be_a(type) }
          end
        end
      end
    end
  end
end
