class RestaurantsController < ApplicationController
     before_action :redirect_if_not_logged_in?
     before_action :set_city, only: [:new, :create]


  def new
      if params[:city_id] && !City.exists?(params[:city_id])
        redirect_to cities_path #
      else
         @restaurant = Restaurant.new(city_id: params[:city_id])
         set_city
      end
  end 


  def create
      @restaurant = current_user.restaurants.new(restaurant_params)
      if @restaurant.save
         redirect_to restaurant_path(@restaurant)
      else 
         render :new
      end 
  end


  def index
      if params[:city_id]
         set_city
            if @city.nil?
              redirect_to cities_path
            else
              @restaurants = @city.restaurants
            end
      else
         @restaurants = Restaurant.all.order_by_creation
      end
    end 


  def show
      if params[:city_id]
         set_city
         @restaurant = @city.restaurants.find_by_id(params[:id])
            if @restaurant.nil?
               redirect_to city_restaurants_path(@city)
            end
      else
         set_restaurant
      end
  end


    def edit
        if params[:city_id]
           city = City.find_by_id(params[:city_id])
           if city.nil?
              redirect_to cities_path
           else
              @restaurant = city.restaurants.find_by_id(params[:id])
              redirect_to city_restaurants_path(city), alert: "restaurant not found" if @restaurant.nil?
        end
           else
            set_restaurant
        end
    end


    def update
        set_restaurant
        @restaurant.update(restaurant_params)
          if @restaurant.save
             redirect_to @restaurant
          else
             render :edit
          end
     end


    def destroy
         set_restaurant.destroy
          if @restaurant.destroy!
             redirect_to restaurants_path
          else
             render :show
          end 
    end


private

   def set_restaurant
      @restaurant = Restaurant.find_by_id(params[:id])
   end 


   def set_city
      @city = City.find_by_id(params[:id])
   end 

   def display_restaurant_errors
      flash.now[:messages] = @restaurant.errors.full_messages
   end 

  
    def restaurant_params
        params.require(:restaurant).permit(:name, 
        :hours, 
        :long_or_short_layover, 
        :price_point, 
        :discount,
        :additional_info,
        :city_id,
        :user_id,
        city_attributes:[:name])
    end
end