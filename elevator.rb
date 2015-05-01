class Elevator

	attr_reader :people_on, :direction, :building, :position, :destination, :destination_queue

	def initialize args
		@max_people=10
		@building=args[:building]
		@position=args[:position]
		@people_on=[]
		@destination_queue=[]
		@floors=@building.floors
		calc_destination
		@direction="stationary"
		@up=1	
		@curr_floor=@floors[@position]
	end

	def load_people#loads people on unless the elevator is full and adds their destination to the queue
		@curr_floor.waiting_list.delete_if do |person|
			if !(@people_on.size==@max_people)
				true
			 	@people_on.push(person)
			 	add_destination(person.dest)		 	
			end
		end
	end

	def empty
		return @people_on.empty?
	end

	def add_destination dest
		unless @destination_queue.include?(dest)
			@destination_queue.push(dest)
		end
	end
	def unload_people#unloads people if @curr_floor is their destination
		@people_on.delete_if do |person|
			if person.dest==@position
				true
				@curr_floor.add_person(person)
			end
		end
	end

	def get_nearest_floor flrs#gets the nearest floor with a button pressed
		positions=[]
		flrs.each do |floor|
			positions.push((floor.position-@position).abs)
		end
		min=100
		i=-1
		(0..positions.size-1).each do |x|
			if positions[x]<min 
				min=positions[x]
				i=x
			end
		end
		return flrs[i].position
	end


	def calc_destination#calculates destination based on @destination_queue
		if @destination_queue.empty?#if destination queue is empty sets destination to first floor with a pressed button
			floors_with_button_pressed=[]
			@floors.each do |floor|
				if floor.button!=nil
					floors_with_button_pressed.push(floor)
				end
			end
			if floors_with_button_pressed.empty?
				@destination=nil #if no buttons are pressed returns to bottom floor
			else
				@destination=get_nearest_floor(floors_with_button_pressed)
			end
		else
			@destination=@destination_queue.shift
		end
	end

	def calc_direction#calculates direction based on destination
		if @destination==nil
			return "stationary", 0
		elsif @destination > @position
			return "up", 1
		else @destination < @position
			return "down", -1
		end
	end

	def tick
		#only stops if more travelling in the elevators direction or it has reached its destination
		if (@curr_floor.button==1&&@up==1)||(@curr_floor.button==0&&@up==0)||@curr_floor.position==@destination
			unless @curr_floor.waiting_list.empty?
				load_people
			end
			unless @people_on.empty?
				unload_people
			end
		end
		if @curr_floor.position==@destination#if destination has reached
			calc_destination
		end
		@curr_floor.press_button
		@direction,@up=calc_direction
		@position=@position+@up
		@curr_floor=@floors[@position]
	end		
end