class CarparksController < ApplicationController


	def get_nearest_carparks
		 return head(:bad_request) unless valid_request?
			latitude = params[:latitude] 
			longitude = params[:longitude]
			page = params[:page]
			per_page = params[:per_page]
			carparks = CarparkInfo.near([latitude,longitude],5,units: :km)
			nearest_carparks = []
			carparks.each do |c|
				carpark_obj = {}
				carpark_no = c.carpark_no
				available_carpark = AvailableCarpark.find_by(carpark_no: carpark_no) rescue nil
				unless available_carpark.nil?
					carpark_obj["address"] = c.address
					carpark_obj["latitude"] = c.latitude
					carpark_obj["longitude"] = c.longitude
					carpark_obj["total_lots"] = available_carpark.total_lots
					carpark_obj["available_lots"] = available_carpark.lots_available
				end
				unless !(carpark_obj["total_lots"].to_i > 0 && carpark_obj["available_lots"].to_i > 0)
					nearest_carparks << carpark_obj
					nearest_carparks = nearest_carparks.sort_by{|nc| [nc["available_lots"],nc["total_lots"]]}
				end
			end
			nearest_carparks  = nearest_carparks.paginate(page: params[:page], per_page: params[:per_page])
		  json_response(nearest_carparks)
	end

	private 

	def valid_request?
		params.has_key?("latitude") && params.has_key?("longitude")
	end

	def carpark_params
		params.require(:carkpark).premit(:carpark_no,:latitude,:longitude,:carpark_type,:parking_system_type,:short_term_parking,:free_parking,:night_parking,:carpark_decks,:grantry_height,:basement_parking)
	end
end
