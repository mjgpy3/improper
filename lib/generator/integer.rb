module Generator
  class Integer
    ARBITRARY_UPPER_BOUND = 123459
    ARBITRARY_LOWER_BOUND = -123459
    ERROR_MESSAGE = 'Difficulty generating Integer. Please ensure properties are correct'

    def initialize(quantity)
      @quantity = quantity
      @lower_bound = ARBITRARY_LOWER_BOUND
      @upper_bound = ARBITRARY_UPPER_BOUND
      @conditions = [->(x){ !x.nil? }]
      @depth_count = 0
      yield(generate_random) if block_given?
    end

    ['', 'and_'].each do |chain_prefix|
      ['above', 'below'].each do |place|
        class_eval <<-BoundsMethods
        def #{chain_prefix}#{place}(bound)
          @#{(place == 'above' ? 'lower' : 'upper')}_bound = bound
          yield(generate_random) if block_given?
          self
        end
        BoundsMethods
      end
    end

    ['even', 'odd'].each do |question|
      class_eval <<-QuestionMethods
      def that_is_#{question}
        @conditions << ->(x){ x.#{question}? }
        yield(generate_random) if block_given?
        self
      end
      QuestionMethods
    end

    private

    def generate_random
      fail ERROR_MESSAGE if @depth_count > 3000
      @depth_count += 1

      a_fixnum = rand(@lower_bound..@upper_bound)
      meets_properties?(a_fixnum) ? a_fixnum : generate_random
    end

    def meets_properties?(number)
      @conditions.all? { |c| c.(number) }
    end
  end
end
