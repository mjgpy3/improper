class Generator
  def initialize(quantity)
    @quantity = quantity
    @results = []
    @type = Fixnum
  end

  def number(of_type = Fixnum)
    @type = of_type
    self
  end

  def above(lower_bound)
    @lower_bound = lower_bound
    self
  end

  def first
    int = @lower_bound ? rand(0) + @lower_bound : 42
    [@type.eql?(Float) ? 42.42 : int].first
  end

  def count
    @quantity.is_a?(Fixnum) ? @quantity : 1
  end
end

def generating(quantity)
  Generator.new(quantity)
end
