class CitiesController < ApplicationController
    before_action :redirect_if_not_logged_in?
    

    def new
        if params[:restaurant_id] && restaurant = Restaurant.find_by_id(params[:restaurant_id])
            @restaurant = restaurant.restaurants.build
        else
            @restaurant = Restaurant.new
            @city = @restaurant.build_city
        end 
    end

    def create
        #@restaurant = current_user.restaurants.new(restaurant_params)
        @city = current_user.cities.build(city_params)
        if @city.save!
            flash[:notice] = "city saved!"
            redirect_to cities_path
        else
            @city.build_city unless @city.city 
            render :new
        end   
    end 

    # def new
    #     @city = City.new
    #     @city.restaurants.build(name: 'name')
    # end 

    # def create
    #     @city = current_user.cities.new(city_params)
    #     @city = current_user.cities.build(city_params)
    #     if @city.save!
    #         flash[:notice] = "city saved!"
    #         redirect_to city_path(@city)
    #     else
    #         render :new
    #     end   
    # end 

    def index
        @city = City.all
    end 

    def show
        @city = City.find(params[:id])
    end

    def edit
        @city = City.find_by_id(params[:id])
    end

    def update
        @city = City.find_by_id(params[:id])
        @city.update(city_params)
        if @city.save
            redirect_to city_path      
        else
           render :edit 
        end
     end

     
    def destroy
        @city = City.find_by_id(params[:id]).destroy
        if @city.destroy!
            flash[:notice] = "Okay, its gone!"
           redirect_to cities_path
        else
            render :show
        end
    end 

    private

    def city_params
        params.require(:city).permit(:name, 
        :state_or_country, 
        :airport_code, 
        :hotel,
        :user_id,
        restaurant_attributes: [:name])
    end 
end
