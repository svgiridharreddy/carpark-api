Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope "/api" do 
  	get '/carparks/nearest' => "carparks#get_nearest_carparks"
  end
end
