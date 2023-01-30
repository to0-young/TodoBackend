class UserMailer < ApplicationMailer
  default from: Rails.application.credentials[:support_email]

  def recover_email
    # @user = params[:user]
    # @url  = 'http://example.com/login'
    # mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end


