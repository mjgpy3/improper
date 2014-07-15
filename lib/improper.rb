def generating(quantity)
  thing = Object.new

  def thing.number(of_type = Fixnum)
    of_type.eql?(Float) ? 42.42 : 42
  end

  thing
end
