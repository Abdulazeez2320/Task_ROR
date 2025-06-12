class SessionsController < ApplicationController
    skip_before_action :authenticate_user, only: [:new, :create]
    before_action :redirect_if_authenticated, only: [:new, :create]
    def new
        @user = User.new
    end
    def create
        @user = User.find_by(email: params[:email])
        if @user&.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to root_path, notice: 'Login successful!'
        else
            flash.now[:alert] = 'Invalid email or password'
            render :new, status: :unprocessable_entity
        end
    end
    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: 'Logged out successfully!'
    end

end