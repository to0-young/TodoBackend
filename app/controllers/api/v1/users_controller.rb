class Api::V1::UsersController < ApplicationController
  # def index
  #   users = User.all
  #   render json: users
  # end

  # def show
  #   user = User.find(params[:id])
  #   render json: user, except: :password
  # end

  def create
    user = User.new params.permit(:first_name, :last_name, :email, :password)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    if current_user.update params.permit(:password, :password_confirmation)
      render json: current_user, status: :ok
    else
      render json: { errors: current_user.errors.messages }, status: :unprocessable_entity
    end
  end

  # def destroy
  #   user = user.find(params[:id])
  #   user.destroy
  # end
end

