class Generator
  def initialize(quantity)
    @quantity = quantity
  end

  def number(of_type = Fixnum)
    NumericGenerator.new(@quantity, of_type)
  end
end

class NumericGenerator
  def initialize(quantity, type)
    @quantity = quantity
    @type = type
    @lower_bound = @upper_bound = false
  end

  def above(lower_bound)
    @lower_bound = lower_bound
    self
  end

  def below(upper_bound)
    @upper_bound = upper_bound
    self
  end

  def and_below(upper_bound)
    @upper_bound = upper_bound
    self
  end

  def first
    int = @upper_bound ? rand(@upper_bound-1) : 42
    int = @lower_bound ? rand(@upper_bound ? @upper_bound-1 : 0) + @lower_bound : int
    int = @upper_bound && @lower_bound ? rand(@lower_bound..@upper_bound) : int
    @type.eql?(Float) ? 42.42 : int
  end

  def count
    @quantity.is_a?(Fixnum) ? @quantity : 1
  end
end

def generating(quantity)
  Generator.new(quantity)
end
