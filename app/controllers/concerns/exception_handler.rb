module ExceptionHandler 
	extend ActiveSupport::Concern

	included do
    rescue_from ActionController::ParameterMissing,with: bad_request
  end
    private 

    def bad_request(e)
    	json_response({message: "#{e.message}"},:bad_request)
    end
end