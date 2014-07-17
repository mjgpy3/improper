class Generator
  def initialize(quantity)
    @quantity = quantity
  end

  def number(of_type = Fixnum, &b)
    NumericGenerator.new(@quantity, of_type, &b)
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
    yield(generate_random) if block_given?
  end

  ['', 'and_'].each do |chain_prefix|
    METHOD_TITLE_TO_POSITION.each do |place, position|
      class_eval <<-BoundsMethods
        def #{chain_prefix}#{place}(bound)
          @#{position}_bound = bound
          yield(generate_random) if block_given?
          self
        end
      BoundsMethods
    end
  end

  private

  def generate_random
    raise 'Lower bound cannot exeed upper' if @lower_bound > @upper_bound
    a_fixnum = rand(@lower_bound..@upper_bound)
    @type.eql?(Float) ? a_fixnum*rand : a_fixnum
  end
end

def generating(quantity)
  Generator.new(quantity)
end
