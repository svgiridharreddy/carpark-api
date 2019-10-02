class CarparksController < ApplicationController

	def nearest_carparks
		unless params.has_key?("latitude") && params.has_key?("longitude")
			binding.pry
		end
		
	end
end
