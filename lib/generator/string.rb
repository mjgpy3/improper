module Generator
  class String
    def initialize(quantity, &b)
      yield('') if block_given?
    end

    def of_size(size)
      yield(size.times.reduce('') { |s| s << random_char })
    end

    private

    def random_char
      (' '..'~').to_a.sample
    end
  end
end
