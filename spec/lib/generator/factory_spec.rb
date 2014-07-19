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
