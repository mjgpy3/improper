class Generator
  def initialize(quantity)
    @quantity = quantity
  end

  def number(of_type = Fixnum)
    NumericGenerator.new(@quantity, of_type)
  end
end

class NumericGenerator
  ARBITRARY_UPPER_BOUND = 123459
  ARBITRARY_LOWER_BOUND = -123459

  METHOD_TITLE_TO_POSITION = {
    'above' => 'lower',
    'below' => 'upper',
  }

  def initialize(quantity, type)
    @quantity = quantity
    @type = type
    @lower_bound = ARBITRARY_LOWER_BOUND
    @upper_bound = ARBITRARY_UPPER_BOUND
  end

  ['', 'and_'].each do |chain_prefix|
    ['above', 'below'].each do |place|
      class_eval <<-BoundsMethods
        def #{chain_prefix}#{place}(bound)
          @#{METHOD_TITLE_TO_POSITION[place]}_bound = bound
          self
        end
      BoundsMethods
    end
  end

  def first
    int = rand(@lower_bound..@upper_bound)
    @type.eql?(Float) ? 42.42 : int
  end

  def count
    @quantity.is_a?(Fixnum) ? @quantity : 1
  end
end

def generating(quantity)
  Generator.new(quantity)
end
