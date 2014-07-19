require './lib/generator/integer.rb'

describe Generator::Integer do
  let(:generator) { described_class.new(quantity) }

  context 'when 2 items are generated' do
    let(:quantity) { 2 }

    specify { expect { |b| described_class.new(quantity, &b) }.to yield_control.twice }

    describe '#that_are_even' do
      specify { expect { |b| described_class.new(quantity).that_are_even(&b) }.to yield_control.twice }
    end

    describe '#that_are_odd' do
      specify { expect { |b| described_class.new(quantity).that_are_odd(&b) }.to yield_control.twice }
    end

    describe '#below' do
      specify { expect { |b| described_class.new(quantity).below(5, &b) }.to yield_control.twice }
    end

    describe '#below' do
      specify { expect { |b| described_class.new(quantity).above(5, &b) }.to yield_control.twice }
    end

    describe '#and_below' do
      specify { expect { |b| described_class.new(quantity).and_below(5, &b) }.to yield_control.twice }
    end

    describe '#below' do
      specify { expect { |b| described_class.new(quantity).and_above(5, &b) }.to yield_control.twice }
    end
  end

  context 'when 1 item is generated' do
    let(:quantity) { 1 }

    describe '#that_is_even' do
      specify { generator.that_is_even { |x| expect(x).to be_even } }

      describe '#that_is_odd' do
        specify { expect { generator.that_is_even.that_is_odd { |_| } }.to raise_error }
      end
    end

    describe '#that_is_odd' do
      specify { generator.that_is_odd { |x| expect(x).to be_odd } }
    end

    describe '#below' do
      context 'when told to be below 40' do
        let(:upper_bound) { 40 }

        specify { expect { |b| generator.below(upper_bound, &b) }.to yield_control }
        specify { generator.below(upper_bound) { |x| expect(x).to be <= 40 } }

        context 'and told to be above 40' do
          let(:lower_bound) { 40 }

          specify { expect { |b| generator.below(upper_bound).and_above(lower_bound, &b) }.to yield_control }
          specify { generator.below(upper_bound).and_above(lower_bound) { |x| expect(x).to eql(40) } }
        end

        context 'and told to be above 41' do
          let(:lower_bound) { 41 }

          specify { expect { generator.below(upper_bound).and_above(lower_bound) { |_| } }.to raise_error }
        end
      end
    end

    describe '#above' do
      context 'when told to be above 90' do
        let(:lower_bound) { 90 }

        specify { expect { |b| generator.above(lower_bound, &b) }.to yield_control }
        specify { generator.above(lower_bound) { |x| expect(x).to be >= 90 } }

        context 'and told to be below 90' do
          let(:upper_bound) { 90 }

          specify { expect { |b| generator.above(lower_bound).and_below(upper_bound, &b) }.to yield_control }
          specify { generator.above(lower_bound).and_below(upper_bound) { |x| expect(x).to eql(90) } }
        end
      end
    end
  end
end
