require './spec/spec_helper.rb'
require './lib/improper.rb'

describe '#generating' do
  subject { generating(quantity) }

  {
    a: 'singular',
    20 => 'plural'
  }.each do |param, card|
    context "when #{card}" do
      let(:quantity) { param }

      it { should be_kind_of(Generator::Factory) }

      it 'should pass the quantity down' do
        expect(Generator::Factory).to receive(:new).with(quantity)
        subject
      end
    end
  end
end
