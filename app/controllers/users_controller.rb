class UsersController < ApplicationController
    
    def new
      @user = User.new
    end 


    def create
        @user = User.new(user_params)
            if @user.save
                session[:user_id] = @user.id
                redirect_to users_path(@user)
            else 
                render :new
            end 
    end 

    def index
    end 

    def show
        @user = User.find_by_id(params[:id])
    end

    def destroy
    end 

    private

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end
