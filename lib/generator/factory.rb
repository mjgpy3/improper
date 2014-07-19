require './lib/generator/integer.rb'

module Generator
  class Factory
    def initialize(quantity)
      @quantity = quantity
    end

    def number(of_type = Fixnum, &b)
      result = Generator::Integer.new(@quantity, &b)
    end
  end
end
