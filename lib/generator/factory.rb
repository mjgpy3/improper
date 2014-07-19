require 'generator/integer.rb'

module Generator
  class Factory
    def initialize(quantity)
      @quantity = quantity
    end

    def number(of_type = Fixnum, &b)
      Generator::Integer.new(quantity_to_i, &b)
    end

    alias_method :numbers, :number

    private

    def quantity_to_i
      @quantity.is_a?(Symbol) ? 1 : @quantity
    end
  end
end
