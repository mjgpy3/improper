require './lib/generator/factory.rb'

shared_examples 'a numeric generator factory' do
  [
    [[], 'no type', Generator::Integer],
    [[Fixnum], 'a Fixnum', Generator::Integer],
  ].each do |params, type, expected_generator|
    context "when told to generate #{type}" do

      {
        a: 1,
        5 => 5,
        20 => 20
      }.each do |q, expected_quantity|
        context "and the factory has been given a quantity of #{q.inspect}" do
          let(:quantity) { q }
          it { is_expected.to be_kind_of(expected_generator) }

          it "should pass down the quantity as #{expected_quantity}" do
            expect(expected_generator).to receive(:new).with(expected_quantity)
            subject
          end
        end
      end
    end
  end
end


describe Generator::Factory do
  let(:generator) { described_class.new(quantity) }

  describe '#numbers' do
    subject { generator.numbers }

    it_behaves_like 'a numeric generator factory'
  end

  describe '#number' do
    subject { generator.number }

    it_behaves_like 'a numeric generator factory'
  end
end
