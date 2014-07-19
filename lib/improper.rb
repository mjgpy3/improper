require 'generator/factory.rb'

def generating(quantity)
  Generator::Factory.new(quantity)
end
