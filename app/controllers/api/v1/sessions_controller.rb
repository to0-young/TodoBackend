class Api::V1::SessionsController < ApplicationController
  #

  def show

  end

  def create
    p "qwet1"
    p "qwet2"
    p "qwet3"
    # знайти_юзера в БД по імейлу з параметрів
    # якщо юзер ніл, то відіслати 404 статус із словами, що такого юзер немає
    user = User.find_by_email(params[:email])
    # перевірити чи пароль, який ти надаєш співпадає з паролем знайденого юзера в БД
    if user.nil?
      render json: { message: "There is no such user" }, status: 404
    else
      correct_password = user.authenticate(params[:password])
      if correct_password == false
        render json: { message: 'Password not valid' }, status: 401
        # якщо не співпадає повернути статус 401 із меседжом, що твій пароль не правильний
      end
    end
    #
    # створити сесію з експірейшеном в 1 день
    # дістати ід новоствореної сесії і зашифрувати її за допомогою jwt із експірейшеном в 1 день (далі токен)
    # засетити цей токен в куки
    # повернути 201 респонс із меседжом, що все добре
  end

  def destroy


  end
end

