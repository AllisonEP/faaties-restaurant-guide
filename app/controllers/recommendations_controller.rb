class RecommendationsController < ApplicationController
    before_action :redirect_if_not_logged_in?

    def new
        if params[:restaurant_id] && !Restaurant.exists?(params[:restaurant_id])
            redirect_to restaurants_path, alert: "restaurant not found"
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
          flash.now[:messages] = @restaurant.errors.full_messages
          render :new
       end
    end

    def show
    end

    def index
    end

    def edit
    end

    private

    def set_restaurant
        @restaurant = Restaurant.find_by_id(params[:restaurant_id])
    end
    
    def recommendation_params
        params.require(:recommendation).permit(:try, :avoid, :restaurant_id, :user_id)
    end
   
end
