class RecommendationsController < ApplicationController
    before_action :redirect_if_not_logged_in?

    def new
        if params[:restaurant_id] && !Restaurant.exists?(params[:restaurant_id])
            redirect_to recommendations_path, alert: "Rec. not found"
          else
            @recommendaton = Recommendation.new(restaurant_id: params[:restaurant_id])
          end
    end

    def create
        @recommendation = current_user.recommendations.new(recommendation_params)
        #@restaurant = current_user.Restaurant.build(restaurant_params)
        if @recommendation.save!
            flash[:notice] = "rec. saved!"
            redirect_to recommnedation_path(@recommendation)
        else
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

    def recommendation_params
        params.require(:recommendation).permit(:try, :avoid, :restaurant_id)
    end
end
