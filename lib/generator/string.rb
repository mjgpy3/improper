module Generator
  class String
    def initialize(quantity, &b)
      @values = (' '..'~')
      @size = rand(13)
      @quantity = quantity
      yield_quantity_times_if_block(&b)
    end

    def of_size(size, &b)
      @size = size
      yield_quantity_times_if_block(&b)
      self
    end

    def from_values(values, &b)
      @values = values
      yield_quantity_times_if_block(&b)
      self
    end

    private

    def yield_quantity_times_if_block
      @quantity.times { yield(generate_string) } if block_given?
    end

    def generate_string
      @size.times.reduce('') { |s| s << @values.to_a.sample }
    end
  end
end
