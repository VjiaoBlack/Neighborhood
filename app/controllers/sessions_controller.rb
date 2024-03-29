class SessionsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by_email(params[:session][:email])
        if @user && @user.authenticate(params[:session][:password])
            session[:user_id] = @user.id
            redirect_to "", notice: "logged in"
        else
            flash.now.alert = "Email or password is invalid"
            redirect_to "/sessions/new"
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_url, notice: "Logged out!"
    end
end
