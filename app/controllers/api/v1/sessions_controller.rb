class Api::V1::SessionsController < ApplicationController
  def show
    return session_empty! if current_session.nil?
    render json: ActiveModelSerializers::SerializableResource.new(current_session).to_json
  end

  def create
    if !cookies[:session].blank?
      return render json: { message: 'Session already active' }, status: 401
    end
    # знайти_юзера в БД по імейлу з параметрів
    user = User.find_by_email(params[:email])

    # якщо юзер ніл, то відіслати 404 статус із словами, що такого юзер немає
    if user.nil?
      # перевірити чи пароль, який ти надаєш співпадає з паролем знайденого юзера в БД
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
    # cookies[:session] = { value: token, expires: 24.hours, domain: request.host, secure: Rails.application.credentials[:jwt_secure] }
    cookies[:session] = { value: token, expires: 24.hours, same_site: :none, secure: Rails.application.credentials[:jwt_secure] }

    # повернути 201 респонс із меседжом, що все добре
     render json: ActiveModelSerializers::SerializableResource.new(current_session).to_json, status: 201
  end

  def destroy
    # якщо карент сесії немає - повернути 401 статус з меседжом session missing
    if current_session.nil?
      return render json: { message: 'Session missing' }, status: 401
    end
    # ЗААПДЕЙТИТИ КАРЕНТ СЕШЕН EXPIRATION DateTime.now
    current_session.update(expiration: DateTime.now)
    # видалити сесію з куки
    cookies.delete(:session, domain: request.host)
    # повернути 200 статус
    render json: { message: 'ок' }, status: 200
  end
end

