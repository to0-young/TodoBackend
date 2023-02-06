class Api::V1::ForgetPasswordsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user.nil?
      render json: { message: "User with this email does not exist"}, status: :not_found
    else
      UserMailer.with(user: user).recover_email.deliver_later
      render json: { message: "Sent a recover email to #{user.email}"}, status: :created
    end
  end
end

