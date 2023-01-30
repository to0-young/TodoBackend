class Api::V1::ForgetPasswordsController < ApplicationController
  def index

  end

  def create
    user = User.find_by_email(params[:email])
    if user.nil?
      render json: { message: "User with this email does not exist"}, status: :not_found
    else

    end
  end
end

