class Api::V1::GoogleController < ApplicationController
  def create
    # Знайти користувача за email
    user = User.find_by(email: google_params[:email])

    # Якщо користувача не знайдено, створити нового користувача
    if user.nil?
      user = User.create(email: google_params[:email],
                         first_name: google_params[:first_name],
                         last_name: google_params[:last_name])
    end

    # Створити сесію для користувача
    exp = 24.hours.from_now
    session = Session.create!(expiration: exp, user_id: user.id)

    # Створити JWT токен для сесії
    exp_payload = { session_id: session.id }
    token = JWT.encode(exp_payload, Rails.application.credentials[:jwt_secret], 'HS256')

    # Встановити токен у куках
    cookies[:session] = { value: token, expires: 24.hours, domain: request.host, secure: Rails.application.credentials[:jwt_secure] }

    # Повернути успішну відповідь
    render json: { user: user }, status: :created
  end

  private

  def google_params
    params.require(:google).permit(:email, :first_name, :last_name)
  end
end
