require 'generator/integer.rb'
require 'generator/string.rb'

module Generator
  class Factory
    def initialize(quantity)
      @quantity = quantity
    end

    def number(of_type = Fixnum, &b)
      Generator::Integer.new(quantity_to_i, &b)
    end

    def string(&b)
      Generator::String.new(quantity_to_i, &b)
    end

    alias_method :numbers, :number
    alias_method :strings, :string

    private

    def quantity_to_i
      @quantity.is_a?(Symbol) ? 1 : @quantity
    end
  end
end
