module Generator
  class String
    def initialize(quantity, &b)
      @values = (' '..'~')
      @size = rand(13)
      quantity.times { yield(generate_string) } if block_given?
    end

    def of_size(size)
      @size = size
      yield(generate_string) if block_given?
      self
    end

    def from_values(values)
      @values = values
      yield(generate_string) if block_given?
      self
    end

    private

    def generate_string
      @size.times.reduce('') { |s| s << @values.to_a.sample }
    end
  end
end
