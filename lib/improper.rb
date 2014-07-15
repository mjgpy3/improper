class Generator
  def initialize(quantity)
    @quantity = quantity
  end

  def number(of_type = Fixnum)
    result = [of_type.eql?(Float) ? 42.42 : 42]
    result << Object.new if @quantity == 2
    result
  end
end

def generating(quantity)
  Generator.new(quantity)
end
