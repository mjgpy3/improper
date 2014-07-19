require 'generator/integer.rb'

module Generator
  class Factory
    def initialize(quantity)
      @quantity = quantity
    end

    def number(of_type = Fixnum, &b)
      Generator::Integer.new(@quantity == :a ? 1 : @quantity, &b)
    end

    alias_method :numbers, :number
  end
end
