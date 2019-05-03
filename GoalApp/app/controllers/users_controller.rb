class UsersController < ApplicationController
    def index
        @users = User.all
        render :index
    end

    def new
        render :new
    end

    def show
        @user = current_user
        render :show
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to users_url
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def destroy
        @user = User.find_by(id: params[:id])
        @user.delete
        redirect_to users_url
    end


    private

    def user_params
        params.require(:user).permit(:username, :password)
    end


end 