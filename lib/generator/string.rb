module Generator
  class String
    def initialize(quantity, &b)
      yield('')
    end
  end
end
