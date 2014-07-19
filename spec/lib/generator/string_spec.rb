require './lib/generator/string.rb'

describe Generator::String do
  let(:generator) { described_class.new(quantity) }

  [2, 10].each do |q|
    context "when #{q} items are generated" do
      let(:quantity) { q }

      specify { expect { |b| described_class.new(quantity, &b) }.to yield_control.exactly(q).times }

      {
        of_size: 5,
        from_values: ['a']
      }.each do |method_name, param|
        describe "##{method_name}" do
          specify { expect { |b| described_class.new(quantity).send(method_name, param, &b) }.to yield_control.exactly(q).times }
        end
      end
    end
  end

  context 'when 1 item is generated' do
    let(:quantity) { 1 }

    context 'when given a block' do
      specify { expect { |b| described_class.new(quantity, &b) }.to yield_control }
      specify { described_class.new(quantity) { |x| expect(x).to be_a_kind_of(String) } }
    end

    describe '#from_values' do
      context 'when an array of values is given' do
        let(:values) { ['f', 'o', 'b', 'a', 'r'] }

        specify { generator.from_values(values) { |x| x.each_char { |c| expect(values).to include(c) } } }
      end

      context 'when given a specific range of just lower letters' do
        let(:range) { 'a'..'z' }

        specify { expect(generator.from_values(range)).to be_kind_of(Generator::String) }

        specify { generator.from_values(range) { |x| x.each_char { |c| expect(range).to include(c) } } }

        describe '#of_size' do
          context 'when some size is given' do
            let(:size) { 5 }

            specify { generator.from_values(range).of_size(size) { |x| x.each_char { |c| expect(range).to include(c) } } }
          end
        end
      end
    end

    describe '#of_sizes' do
      specify { expect(generator.of_sizes([1, 2, 3])).to be_kind_of(Generator::String) }

      context 'when given a flat array of params' do
        describe '#size' do
          specify { generator.of_sizes(3,7) { |x| expect([3, 7]).to include(x.size) } }
        end
      end

      context 'when given a range' do
        describe '#size' do
          specify { generator.of_sizes(30..42) { |x| expect(30..42).to include(x.size) } }
        end
      end

      context 'when the sizes are [5]' do
        let(:sizes) { [5] }

        describe '#size' do
          specify { generator.of_sizes(sizes) { |x| expect(sizes).to include(x.size) } }
        end
      end
    end

    describe '#of_size' do
      specify { expect(generator.of_size(4)).to be_kind_of(Generator::String) }

      [0, 1, 2, 5].each do |s|
        context "when the size is #{s}" do
          let(:size) { s }

          describe '#from_values' do
            context 'when some range is given' do
              let(:range) { 'a'..'f' }

              describe '#size' do
                specify { generator.of_size(s).from_values(range) { |x| expect(x.size).to eq(s) } }
              end
            end
          end

          describe '#size' do
            specify { generator.of_size(s) { |x| expect(x.size).to eq(s) } }
          end
        end
      end
    end
  end
end
