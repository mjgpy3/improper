module Generator
  class Integer
    ARBITRARY_UPPER_BOUND = 123459
    ARBITRARY_LOWER_BOUND = -123459
    BOUNDS_ERROR = 'Lower bound cannot exeed upper'
    EVEN_AND_ODD_ERROR = 'Cannot ensure even and odd'

    METHOD_TITLE_TO_POSITION = {
      'above' => 'lower',
      'below' => 'upper',
    }

    def initialize(quantity, type)
      @quantity = quantity
      @type = type
      @lower_bound = ARBITRARY_LOWER_BOUND
      @upper_bound = ARBITRARY_UPPER_BOUND
      @ensure_even = @ensure_odd = false
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

    ['even', 'odd'].each do |question|
      class_eval <<-QuestionMethods
      def that_is_#{question}
        @ensure_#{question} = true
        yield(generate_random) if block_given?
        self
      end
      QuestionMethods
    end

    private

    def yield_or_self
      block_given? ? yield(generate_random) : self
    end

    def generate_random
      guard_inconsistent_properties

      a_fixnum = rand(@lower_bound..@upper_bound)
      a_fixnum = generate_random if fails_property?(a_fixnum)
      @type.eql?(Float) ? a_fixnum*rand : a_fixnum
    end

    def fails_property?(number)
      (@ensure_even && !number.even?) || (@ensure_odd && !number.odd?)
    end

    def guard_inconsistent_properties
      raise BOUNDS_ERROR if @lower_bound > @upper_bound
      raise EVEN_AND_ODD_ERROR if @ensure_even && @ensure_odd
    end
  end
end
