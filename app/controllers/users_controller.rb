class UsersController < ApplicationController
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path
        else
            redirect_to "/users/new"
        end
    end

    def new
        @user = User.new
    end

    def show
        if session[:user_id]
            @user = User.find(session[:user_id])
            @events = Event.where(user_id: session[:user_id])
        else
            render text: "whoops, log in first"
        end
    end


    private
        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end
end
