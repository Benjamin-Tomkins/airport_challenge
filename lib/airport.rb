require_relative 'weather'
require_relative 'plane'

class Airport

	DEFAULT_CAPACITY = 5

	attr_accessor :capacity, :planes_on_the_ground, :planes_in_the_sky, :weather

	def initialize(capacity = DEFAULT_CAPACITY, weather = Weather.new)
		@capacity = capacity
		@planes_in_the_sky = []
		@planes_on_the_ground = []
		@weather = weather
	end

	def takeoff(plane)
		fail 'Cannot takeoff when stormy' if stormy?
		fail 'Planes in the sky cannot take off' if @planes_in_the_sky.include?(plane)
		fail 'Plane cannot take off as it is not at this airport' unless @planes_on_the_ground.include?(plane)
		@planes_in_the_sky << plane
		@planes_on_the_ground.delete(plane)		
	end

	def land(plane)
		fail 'Cannot land when stormy' if stormy?
		fail 'No apron slots available' if maximum_capacity?
		@planes_on_the_ground << plane
	end

	def maximum_capacity?
		@planes_on_the_ground.count == @capacity
	end

	def stormy?
		weather.stormy?
	end

end
