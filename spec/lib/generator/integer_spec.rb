require './lib/generator/integer.rb'

describe Generator::Integer do
  let(:generator) { described_class.new(quantity) }

  [2, 3, 1000].each do |q|
    context "when #{q} items are generated" do
      let(:quantity) { q }

      specify { expect { |b| described_class.new(quantity, &b) }.to yield_control.exactly(q).times }

      ['that_are_even', 'that_are_odd'].each do |method_name|
        describe "##{method_name}" do
          specify { expect { |b| described_class.new(quantity).send(method_name, &b) }.to yield_control.exactly(q).times }
        end
      end

      ['below', 'and_below', 'above', 'and_above'].each do |method_name|
        describe "##{method_name}" do
          specify { expect { |b| described_class.new(quantity).send(method_name, 5, &b) }.to yield_control.exactly(q).times }
        end
      end
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
