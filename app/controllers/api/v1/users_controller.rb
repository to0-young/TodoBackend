class Api::V1::UsersController < ApplicationController
  before_action :authenticate!, only: :update


  # def index
  #   users = User.all
  #   render json: users
  # end

  # def show
  #   user = User.find(params[:id])
  #   render json: user, except: :password
  # end

  def create
    user = User.new(user_params)
    if user.save
      UserMailer.with(user: user).confirm_email.deliver_later
      render json: { message: "Sent a confirm email to #{user.email}"}, status: :created
    else
      render json: { errors: user.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    if current_user.update(user_update_params)
      render json: current_user, status: :ok
    else
      render json: { errors: current_user.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :avatar)
  end

  def user_update_params
    params.permit(:password, :password_confirmation, :email_confirmed, :avatar)
  end


  # def destroy
  #   user = user.find(params[:id])
  #   user.destroy
  # end
end

