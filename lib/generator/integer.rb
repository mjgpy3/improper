module Generator
  class Integer
    ARBITRARY_UPPER_BOUND = 123459
    ARBITRARY_LOWER_BOUND = -123459
    ERROR_MESSAGE = 'Difficulty generating Integer. Please ensure properties are correct'

    def initialize(quantity, &b)
      @quantity = quantity
      @lower_bound = ARBITRARY_LOWER_BOUND
      @upper_bound = ARBITRARY_UPPER_BOUND
      @conditions = [->(x){ !x.nil? }]
      yield_quantity_times_if_block(&b)
    end

    ['', 'and_'].each do |chain_prefix|
      ['above', 'below'].each do |place|
        class_eval <<-BoundsMethods
          def #{chain_prefix}#{place}(bound, &b)
            @#{(place == 'above' ? 'lower' : 'upper')}_bound = bound
            yield_quantity_times_if_block(&b)
            self
          end
        BoundsMethods
      end
    end

    ['even', 'odd'].each do |question|
      ['is', 'are'].each do |plurality|
        class_eval <<-QuestionMethods
          def that_#{plurality}_#{question}(&b)
            @conditions << ->(x){ x.#{question}? }
            yield_quantity_times_if_block(&b)
            self
          end
        QuestionMethods
      end
    end

    private

    def yield_quantity_times_if_block
      return unless block_given?
      @quantity.times do
        @depth_count = 0
        yield(generate_random)
      end
    end

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
