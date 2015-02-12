class PlacesController < ActionController::Base

	def index

	end

	def search
		params[:city]
   		render :index
	end	
	
end