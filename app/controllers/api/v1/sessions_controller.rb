class Api::V1::SessionsController < ApplicationController

  def show
    token = cookies[:session]
    begin
      decoded_token = JWT.decode(token, Rails.application.credentials[:jwt_secret], true, { algorithm: 'HS256' })
      session_id = decoded_token[0]['session_id']
      session = Session.find_by_id(session.user)
    rescue JWT::ExpiredSignature
      # Handle expired token, e.g. logout user or deny access
    end
  end

  def create
    if !cookies[:session].blank?
      return render json: { message: 'Session already active' }, status: 401
    end

    # знайти_юзера в БД по імейлу з параметрів
    # якщо юзер ніл, то відіслати 404 статус із словами, що такого юзер немає
    user = User.find_by_email(params[:email])
    # перевірити чи пароль, який ти надаєш співпадає з паролем знайденого юзера в БД
    if user.nil?
      return render json: { message: "There is no such user" }, status: 404
    else
      correct_password = user.authenticate(params[:password])
      if correct_password == false
        # якщо не співпадає повернути статус 401 із меседжом, що твій пароль не правильний
        return render json: { message: 'Password not valid' }, status: 401
      end
    end
    exp = 24.hours.from_now
    # створити сесію з експірейшеном в 1 день
    session = Session.create!(expiration: exp, user_id: user.id)

    # зашифрувати її за допомогою jwt із експірейшеном в 1 день (далі токен)
    exp_payload = { session_id: session.id }
    token = JWT.encode(exp_payload, Rails.application.credentials[:jwt_secret], 'HS256')

    # засетити цей токен в куки
    cookies[:session] = { value: token, expires: 24.hours }

    # повернути 201 респонс із меседжом, що все добре
    return render json: { message: 'Session created' }, status: 201
  end

  def destroy
    user = user
    if user
      cookies.delete(:jwt)
      render json: {status: 'OK', code: 200}
    else
      render json: {status: 'session not found', code: 404}
    end
  end
end

