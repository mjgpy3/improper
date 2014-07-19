module Generator
  class Factory
    def initialize(quantity)
      @quantity = quantity
    end

    def number(of_type = Fixnum, &b)
      NumericGenerator.new(@quantity, of_type, &b)
    end
  end
end
