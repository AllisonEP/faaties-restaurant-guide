class CitiesController < ApplicationController
    before_action :redirect_if_not_logged_in?
    

    def new
        if params[:restaurant_id] && restaurant = Restaurant.find_by_id(params[:restaurant_id])
           @restaurant = restaurant.restaurants.build
        else
            @restaurant = Restaurant.new
            @city = City.new
            set_restaurant
        end 
    end

    
    def create
        @restaurant = current_user.restaurants.new 
        @city = current_user.cities.build(city_params)
            if @city.save
               redirect_to cities_path
            else
               render :new
            end   
    end 


    def index 
        if params[:restaurant_id]
            set_restaurant
             if restaurant.nil?
                redirect_to restaurants_path
             else
                @city = @restaurant.cities 
             end 
        else
           @city = City.all.order_by_alphabet
        end
    end 


    def show
        set_city
    end


    def edit
        set_city
    end


    def update
        set_city
        @city.update(city_params)
            if @city.save
               redirect_to city_path      
            else
               render :edit 
            end
    end

     
    def destroy
        set_city.destroy
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
  

    def set_restaurant
        @restaurant = Restaurant.find_by_id(params[:id])
      end 

    def city_params
        params.require(:city).permit(:name, 
        :state_or_country, 
        :airport_code, 
        :hotel,
        :user_id,
        :restaurant_id,
        restaurant_attributes: [:name])
    end 
end
