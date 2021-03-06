module Generator
  class String
    def initialize(quantity, &b)
      @values = (' '..'~')
      @sizes = 0..13
      @quantity = quantity
      yield_quantity_times_if_block(&b)
    end

    def of_sizes(*sizes, &b)
      @sizes = sizes.first.respond_to?(:to_a) ? sizes.first : sizes
      yield_quantity_times_if_block(&b)
      self
    end

    def from_values(values, &b)
      @values = values
      yield_quantity_times_if_block(&b)
      self
    end

    alias_method :of_size, :of_sizes

    def to_a
      @quantity.times.collect { generate_string }
    end

    private

    def yield_quantity_times_if_block
      @quantity.times { yield(generate_string) } if block_given?
    end

    def generate_string
      @sizes.to_a.sample.times.reduce('') { |s| s << @values.to_a.sample }
    end
  end
end
