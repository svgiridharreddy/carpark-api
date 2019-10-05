module Response 
	extend ActiveSupport::Concern
	included do 
		def json_response(obj,status = :ok)
			render json: obj,status: status
		end
	end
end