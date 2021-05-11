class RecommendationsController < ApplicationController
    before_action :redirect_if_not_logged_in?

    def new
        if params[:restaurant_id] && !Restaurant.exists?(params[:restaurant_id])
            redirect_to restaurants_path
          else
            @recommendation = Recommendation.new(restaurant_id: params[:restaurant_id])
            set_restaurant
          end
    end


    def create
        @recommendation = Recommendation.new(recommendation_params)
        @recommendation = Recommendation.new(restaurant_id: params[:restaurant_id])
        @recommendation.user = current_user
       if @recommendation.save
          redirect_to restaurant_path(params[:restaurant_id])
       else
          render :new
       end
    end


    def show
        if params[:restaurant_id]
            set_restaurant
            @recommendation = @restaurant.recommendations.find_by_id(params[:id])
               if @recommendation.nil?
                  #redirect_to city_restaurants_path(@city)
               end
         else       
            @recommendation = Recommendation.find_by_id(params[:recommendation_id])
         end
    end


    def index
        if params[:restaurant_id]
            set_restaurant
               if @restaurant.nil?
                 redirect_to restaurants_path, alert: "Restaurant not found"
               else
                 @recommendations = @restaurant.recommendations
               end
        else
            @recommendations = Recommendation.all
        end
    end

    def edit
    end

    private

    def set_restaurant
        @restaurant = Restaurant.find_by_id(params[:restaurant_id])
    end
    
    def recommendation_params
        params.require(:recommendation).permit(:try, :avoid, :restaurant_id, :user_id, restaurant_attributes: [:name])
    end
   
end
