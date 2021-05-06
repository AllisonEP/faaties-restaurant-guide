class RecommendationsController < ApplicationController
    before_action :redirect_if_not_logged_in?

    def new
    @recommendation = Recommendation.new
    end
# # 
#     def create
#         @recommendation = @restaurant_list.recommendations.new(restaurant_list_params)
#         if @recommendation.save
#           redirect_to @restaurant_list, success: 'Rec.created.'
#         else
#           render :show
#         end
#     end

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

    def set_restaurant_list
        @recommendation_list = RecommendationList.includes(:recommendations)
                             .where(user: current_user)
                             .find(params[:restaurant_list_id])
      end
    
end
