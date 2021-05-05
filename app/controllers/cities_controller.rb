class CitiesController < ApplicationController
    before_action :redirect_if_not_logged_in?
    
    def new
        @city = City.new
    end 

    def create
        @city = current_user.cities.new(city_params)
        @city = current_user.restaurants.build(city_params)
        if @city.save!
            flash[:notice] = "city saved!"
            redirect_to cities_path
        else
            render :new
        end   
    end 

    def index
        
    end 

    def show
        @city = City.find(params[:id])
    end


    private

    def city_params
        params.require(:city).permit(:name, 
        :state_or_country, 
        :airport_code, 
        :hotel)
    end 
end
