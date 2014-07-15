class Generator
  def initialize(quantity)
    @quantity = quantity
  end

  def number(of_type = Fixnum)
    [of_type.eql?(Float) ? 42.42 : 42]
  end
end

def generating(quantity)
  Generator.new(quantity)
end
