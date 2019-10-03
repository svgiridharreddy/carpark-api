require 'csv'
namespace :dump do 

  desc "dump carpark info from csv"
  task carpark_information: :environment do 
  	CSV.foreach("public/carpark_information.csv", :headers=>true).each_with_index do |row,index|
  		begin 
  			x_coord = row[2].to_f
  			y_coord = row[3].to_f
  			latitude,longitude  = SVY21.svy21_to_lat_lon(x_coord, y_coord)
  			carpark_info = CarparkInfo.find_or_create_by(carpark_no: row[0])
  			carpark_info.address = row[1]
  			carpark_info.latitude = latitude
  			carpark_info.longitude = longitude
  			carpark_info.carpark_type = row[4]
  			carpark_info.parking_system_type = row[5]
  			carpark_info.short_term_parking = row[6]
  			carpark_info.free_parking = row[7]
  			carpark_info.night_parking = row[8].downcase == "yes" ? true : false
  			carpark_info.carpark_decks = row[9].to_i
  			carpark_info.grantry_height = row[10].to_f
  			carpark_info.basement_parking = row[11] == "Y" ? true : false
  			carpark_info.save!
  			puts "#{index+1} records saved!"
  		rescue StandardError => e
  			puts e.message
  			e.backtrace
  		end
  	end
  end

	desc "fetch and update available carparks from api "
  task available_carparks: :environment do
  	begin
			api_url = "https://api.data.gov.sg/v1/transport/carpark-availability"
		 	api_response = HTTParty.get(api_url)	
		 	available_carparks = api_response["items"][0]["carpark_data"]
		 	count = 0
		 	available_carparks.each do |carpark|
		 		carpark_number = carpark["carpark_number"]
		 		update_datetime = carpark["update_datetime"]
		 		carpark_info = carpark["carpark_info"][0]
        total_lots = carpark_info["total_lots"]
        lot_type = carpark_info["lot_type"]
        lots_available = carpark_info["lots_available"]
		 		available_carpark = AvailableCarpark.find_or_create_by(carpark_no: carpark_number)
		 		available_carpark.carpark_info = carpark_info
        available_carpark.total_lots = total_lots
        available_carpark.lot_type  = lot_type
        available_carpark.lots_available  = lots_available
		 		available_carpark.update_datetime = update_datetime
		 		available_carpark.save!
		 		puts "#{count+=1} records inserted"
		 	end
		rescue StandardError => e 
			puts e.message
			e.backtrace
		end
  end
end