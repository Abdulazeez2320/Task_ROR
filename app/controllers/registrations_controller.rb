class RegistrationsController < ApplicationController

    skip_before_action :authenticate_user, only: [:new, :create]
    before_action:redirect_if_authenticated, only: [:new, :create]

    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path, notice: 'Registration successful!'
        else
            render :new, status: :unprocessable_entity
        end
    end
    private
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
