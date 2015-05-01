require './simulation'
require './building'
require './elevator'
require './floor'
require './person'



simul = Simulation.new(:number_of_floors => 8)

simul.add_people(10)

simul.run(50)