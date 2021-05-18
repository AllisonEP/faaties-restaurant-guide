class SessionsController < ApplicationController

    def new
    end

    def create
        user = User.find_by(username: params[:user][:username])
            if user && user.authenticate(params[:user][:password])
               session[:user_id] = user.id
               redirect_to user_path(user)
            else 
               redirect_to "/login"
           end 
    end

      # question: can we walk through this 

    def destroy
        session.clear
        redirect_to root_path
    end 

    def google_login
        user_email = request.env['omniauth.auth']['info']['email']
        user_name = request.env['omniauth.auth']['info']['name']
        user = User.find_or_create_by(email: user_email) do |user|
            user.username = user_name
            user.password = SecureRandom.hex
        end
        session[:user_id] = user.id
        
        redirect_to user_path(user)
    end

end 