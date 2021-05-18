
class RestaurantsController < ApplicationController
   before_action :redirect_if_not_logged_in?
   before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
   before_action :set_city, only: [:new, :create]
   # we only really need to set city for new/create ebc in th eothere actions the association alraedy exists

     
   def new
       if params[:city_id] && !City.exists?(params[:city_id])
       # if there is params city id it means if we are within the nest routes creating a city a city id and making sure a city exists with an id for the city parameters 
       # if there isnt a city that exists w/ the id we are getting from our parameters then redirect
         redirect_to cities_path 
       else
         @restaurant = Restaurant.new(city_id: params[:city_id])
       # calling .new on a restuarant w/ the id of the city params that I passed in 
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
          if @city.nil?
            redirect_to cities_path
          else
            @restaurants = @city.restaurants
          end
      else
          @restaurants = Restaurant.all.order_by_name
      end
   end 


   def show
   end


   def edit      
   end

  # the resuarant doesnt need to benested in anything to edit the city so that code was superfluous


  def update
      @restaurant.update(restaurant_params)
      # params are coming from forms, ex. restaurant has name and price point so we can use restaurant_params
        if @restaurant.save
           redirect_to @restaurant
        else
           render :edit
        end
   end


  def destroy
    # one of the resources in the routes is destroy, so the destroy action is a delete request b dafault which is why i dont need to call .destroy
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

