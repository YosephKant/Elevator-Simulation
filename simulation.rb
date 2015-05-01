class Simulation
	attr_accessor :building

	def initialize args
		@building=Building.new(args)
	end

	def add_people number
		(1..number).each do |num|#gets two unique random floors
			rand_floor=rand(@building.number_of_floors)
			rand_floor2=rand(@building.number_of_floors)
			while(rand_floor2==rand_floor)
				rand_floor2=rand(@building.number_of_floors)
			end
			person=Person.new(:start=>rand_floor, :dest=>rand_floor2)
			@building.add_person(person)
		end
	end	

	def run (ticks)
		@building.elevator.calc_destination
		(1..ticks).each do |tick|		
			puts "#{tick} seconds passed"
			self.tick		
			if @building.all_destinations_reached
				break
			end
		end
	end

	def tick 
		@building.tick
		sleep(1)
	end
end
