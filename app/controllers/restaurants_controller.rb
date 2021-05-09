class RestaurantsController < ApplicationController
     before_action :redirect_if_not_logged_in?
    #  before_action :set_city, only: [:new, :create]


  def new
      if params[:city_id] && !City.exists?(params[:city_id])
        redirect_to citys_path, alert: "city not found"
      else
        @restaurant = Restaurant.new(city_id: params[:city_id])
      end
  end 

  def create
    @restaurant = current_user.restaurants.new(restaurant_params)
    if @restaurant.save!
      flash[:notice] = "restaurant saved!"
      redirect_to restaurant_path(@restaurant)
    else 
      flash.now[:messages] = @restaurant.errors.full_messages
      render :new
    end 
  end

  def index
      if params[:city_id]
         @city = City.find_by(id: params[:city_id])
            if @city.nil?
              redirect_to cities_path, alert: "city not found"
            else
              @restaurants = @city.restaurants
            end
        else
            @restaurants = Restaurant.all
        end
    end 

  def show
      if params[:city_id]
         @city = City.find_by(id: params[:city_id])
         @restaurant = @city.restaurants.find_by(id: params[:id])
            if @restaurant.nil?
               redirect_to city_restaurants_path(@city), alert: "restaurant not found"
            end
      else
         @restaurant = Restaurant.find(params[:id])
      end
  end

    def edit
        if params[:city_id]
           city = City.find_by(id: params[:city_id])
           if city.nil?
              redirect_to cities_path, alert: "city not found"
           else
              @restaurant = city.restaurants.find_by(id: params[:id])
              redirect_to city_restaurants_path(city), alert: "restaurant not found" if @restaurant.nil?
        end
           else
              @restaurant = Restaurant.find(params[:id])
        end
    end

    def update
        @restaurant = Restaurant.find(params[:id])
        @restaurant.update(restaurant_params)
          if @restaurant.save
             redirect_to @restaurant
          else
            flash.now[:messages] = @restaurant.errors.full_messages
             render :edit
          end
     end

    def destroy
        @restaurant = Restaurant.find_by_id(params[:id]).destroy
          if @restaurant.destroy!
             flash[:notice] = "Okay, its gone!"
             redirect_to restaurants_path
          else
             render :show
          end 
    end

private

    def set_city
        @city = City.find_by(id: params[:city_id])
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
        city_attributes: [:name])
    end
end