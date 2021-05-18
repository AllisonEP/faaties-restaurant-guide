class CitiesController < ApplicationController
    before_action :redirect_if_not_logged_in?
    before_action :set_city, except: [:new, :create, :index]
    # this helps make the code cleaner to remove all the city_city I added 

    def new
            @city = City.new     
    end
    #tells new form this is the city we are talking about 

 
    def create
        @city = current_user.cities.build(city_params)
        # creating a new instance of city class & associating it w the user 
        # it is plural bc it is a has many relationship and .city would exist per rails
            if @city.save
               redirect_to cities_path
            else
               render :new
            end   
    end 

    def index 
           @cities = City.all.order_by_name
           # order all of the cities in alphabetical order and sending that message to the view to do 
           # change this instancee variable in the index view for cities
        end

      
    def show
    end

    def edit
    end


    def update
        @city.update(city_params)
            if @city.save
               redirect_to city_path      
            else
               render :edit 
            end
    end

     
    def destroy
            if @city.destroy
                redirect_to cities_path
            else
                render :show
        end
    end 


    private


    def set_city
        @city = City.find_by_id(params[:id])
      end 
  


    def city_params
        params.require(:city).permit(:name, 
        :state_or_country, 
        :airport_code, 
        :hotel,
        :user_id)
    end 
end
