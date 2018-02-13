class Api::V1::UsersController < ApplicationController

    def index
      @users = User.all
      render json: @users
    end

    def find_or_create
      @user = User.find_or_create_by(params[:username])
      if @user
        render json: @user
      else
        redirect_to action: "create"
      end
    end

    def create
      @user = User.new(params[:username])
      if @user.valid?
        @user.save
        render json: @user
      else
        render json: {errors: @user.errors.full_messages}, status: 500
      end
    end

    def update
      @user = User.find(params[:id])
      @user.update(params[:user])
      if @user.save
        render json: @user
      else
        render json: {errors: @user.errors.full_messages}, status: 422
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
    end

    # private
    # def user_params
    #   params.require(:username).permit(:username, :theme)
    # end

end
