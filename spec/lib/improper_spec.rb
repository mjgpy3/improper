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

      describe '#below' do
        context 'when told to be below 40' do
          let(:upper_bound) { 40 }
          describe '#first' do
            subject { generator.number.below(upper_bound).first }

            it { is_expected.to be <= 40 }
          end

          context 'and told to be above 40' do
            let(:lower_bound) { 40 }
            describe '#first' do
              subject { generator.number.below(upper_bound).and_above(lower_bound).first }

              it { is_expected.to eql(40) }
            end
          end
        end
      end

      describe '#above' do
        context 'when told to be above 90' do
          let(:lower_bound) { 90 }
          describe '#first' do
            subject { generator.number.above(lower_bound).first }

            it { is_expected.to be >= 90 }
          end

          context 'and told to be below 90' do
            let(:upper_bound) { 90 }
            describe '#first' do
              subject { generator.number.above(lower_bound).and_below(upper_bound).first }

              it { is_expected.to eql(90) }
            end
          end
        end
      end
    end
  end
end
