module Generator
  class String
    def initialize(quantity, &b)
      @range = (' '..'~')
      @size = rand(13)
      yield('') if block_given?
    end

    def of_size(size)
      @size = size
      yield(generate_string) if block_given?
      self
    end

    def in_range(range)
      @range = range
      yield(generate_string) if block_given?
      self
    end

    private

    def generate_string
      @size.times.reduce('') { |s| s << random_char }
    end

    def random_char
      @range.to_a.sample
    end
  end
end
