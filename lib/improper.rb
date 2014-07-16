class Generator
  def initialize(quantity)
    @quantity = quantity
  end

  def number(of_type = Fixnum)
    NumericGenerator.new(@quantity, of_type)
  end
end

class NumericGenerator

  METHOD_TITLE_TO_POSITION = {
    'above' => 'lower',
    'below' => 'upper',
  }

  def initialize(quantity, type)
    @quantity = quantity
    @type = type
    @lower_bound = @upper_bound = false
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
