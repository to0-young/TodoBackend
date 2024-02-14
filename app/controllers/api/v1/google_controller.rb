class Api::V1::GoogleController < ApplicationController
  def create
    # Отримати дані, передані з Google
    google_data = google_params[:google]

    # Пошук користувача за email
    user = User.find_by(email: google_data[:email])

    # Якщо користувача не знайдено, створити нового користувача
    if user.nil?
      user = User.create!(email: google_data[:email],
                         first_name: google_data[:first_name],
                         last_name: google_data[:last_name],
                          password: google_data[:google_id],
                          password_confirmation: google_data[:google_id],
                          email_confirmed: true)
    end

    # експірейшен в 1 день
    exp = 24.hours.from_now

    # створити сесію з експірейшеном в 1 день
    session = Session.create!(expiration: exp, user_id: user.id)

    # зашифрувати її за допомогою jwt із експірейшеном в 1 день (далі токен)1
    exp_payload = { session_id: session.id }
    token = JWT.encode(exp_payload, Rails.application.credentials[:jwt_secret], 'HS256')

    # засетити цей токен в куки
    cookies[:session] = { value: token, expires: 24.hours, domain: request.host, secure: Rails.application.credentials[:jwt_secure] }
    # cookies[:session] = { value: token, expires: 24.hours, same_site: :none, secure: Rails.application.credentials[:jwt_secure] }

    # повернути 201 респонс із меседжом, що все добре
    render json: ActiveModelSerializers::SerializableResource.new(current_session).to_json, status: :created
  end

  private

  def google_params
    params.permit(google: [:email, :first_name, :last_name, :google_id])
  end
end
