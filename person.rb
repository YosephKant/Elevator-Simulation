class Person

  attr_accessor :start, :dest

  def initialize(arg)
    @start=arg[:start]
    @dest=arg[:dest]
  end
end