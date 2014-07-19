require './lib/generator/factory'

describe Generator::Factory do
  let(:generator) { described_class.new(:a) }

  describe '#number' do
    specify { expect { |b| generator.number(&b) }.to yield_with_args(kind_of(Fixnum)) }

    [Fixnum, Float].each do |type|
      context "when told to generate a #{type}" do
        specify { expect { |b| generator.number(type, &b) }.to yield_with_args(kind_of(type)) }
      end
    end

    describe '#that_is_even' do
      specify { generator.number.that_is_even { |x| expect(x).to be_even } }

      describe '#that_is_odd' do
        specify { expect { generator.number.that_is_even.that_is_odd { |_| } }.to raise_error }
      end
    end

    describe '#that_is_odd' do
      specify { generator.number.that_is_odd { |x| expect(x).to be_odd } }
    end

    describe '#below' do
      context 'when told to be below 40' do
        let(:upper_bound) { 40 }

        specify { expect { |b| generator.number.below(upper_bound, &b) }.to yield_control }
        specify { generator.number.below(upper_bound) { |x| expect(x).to be <= 40 } }

        context 'and told to be above 40' do
          let(:lower_bound) { 40 }

          specify { expect { |b| generator.number.below(upper_bound).and_above(lower_bound, &b) }.to yield_control }
          specify { generator.number.below(upper_bound).and_above(lower_bound) { |x| expect(x).to eql(40) } }
        end

        context 'and told to be above 41' do
          let(:lower_bound) { 41 }

          specify { expect { generator.number.below(upper_bound).and_above(lower_bound) { |_| } }.to raise_error }
        end
      end
    end

    describe '#above' do
      context 'when told to be above 90' do
        let(:lower_bound) { 90 }

        specify { expect { |b| generator.number.above(lower_bound, &b) }.to yield_control }
        specify { generator.number.above(lower_bound) { |x| expect(x).to be >= 90 } }

        context 'and told to be below 90' do
          let(:upper_bound) { 90 }

          specify { expect { |b| generator.number.above(lower_bound).and_below(upper_bound, &b) }.to yield_control }
          specify { generator.number.above(lower_bound).and_below(upper_bound) { |x| expect(x).to eql(90) } }
        end
      end
    end
  end
end

