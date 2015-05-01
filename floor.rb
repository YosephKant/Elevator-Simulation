class Floor

	attr_accessor :building, :position, :waiting_list, :arrived_list, :button

	def initialize args
		@building=args[:building]
		@position=args[:position]
		@waiting_list=[]
		@arrived_list=[]
		@button=nil
	end

	def add_person person
		if person.dest==@position
			@arrived_list.push(person)
		else
			@waiting_list.push(person)
		end
	end

	def press_button#calculates if there are more people travelling up or down. 1 for down and 2 for up
		if @waiting_list.size>0
			num_up=0
			num_down=0
			@waiting_list.each do |person|
				if person.dest>@position
					num_up=num_up+1
				else
					num_down=num_up+1
				end
			end
			if num_up >= num_down
				@button=1
			else
				@button=0
			end
		else
			@button=nil
		end
	end
end