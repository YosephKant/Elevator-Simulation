class Building

	attr_accessor :number_of_floors, :all_destinations_reached, :floors, :elevator

	def initialize args
		@number_of_floors=args[:number_of_floors]
		@floors=[]
		make_floors
		@elevator=make_elevator
		@all_destinations_reached=false
	end

	def make_floors#initiate all the floors of the building and add to add to the @floors list
		(0..number_of_floors-1).each do |floor|
			temp=Floor.new(:building=>self, :position=>floor)
			@floors.push(temp)
		end
	end

	def make_elevator#initializes elevator
		@elevator=Elevator.new(:building=>self, :position=>0)
	end

	def add_person person#adds a person to the floor's waiting list and presses the button on the floor
		find_floor=floors[person.start]
		find_floor.add_person(person)
		find_floor.press_button
	end

	def check_all_destinations_reached
		@floors.each do |floor|
			if floor.button!=nil
				@all_destinations_reached=false
				return
				#if any button is still pressed returns false
			end
		end
		if @elevator.empty
			@all_destinations_reached=true	#if there are no buttons pressed and no people on elevator returns true
		else
			@all_destinations_reached=false		#if there are still people on the elevator returns false
		end
	end

	def print_building
		#prints the position of the building
		$stdout.sync = true
		puts "<><><><><><><><><><><><><><><><><><><><><><><><><><><>"
		@floors.each do |floor|
			print "Floor Number:#{floor.position} People Waiting:[#{floor.waiting_list.size}]People Arrived:[#{floor.arrived_list.size}]"
			if @elevator.position==floor.position
				print "{#{@elevator.people_on.size}} travelling #{@elevator.direction}"
			end
			puts ""
		end
		puts "<><><><><><><><><><><><><><><><><><><><><><><><><><><>"
	end
	def tick		
		@elevator.tick
		@all_destinations_reached=check_all_destinations_reached
		self.print_building
	end
end

