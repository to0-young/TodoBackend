class UserMailer < ApplicationMailer
  default from: Rails.application.credentials[:support_email]

  def recover_email
    @user = params[:user]
    exp_payload = { user_id: @user.id }
    recovery_token = JWT.encode(exp_payload, Rails.application.credentials[:jwt_secret], 'HS256')
    @front_end_url = Rails.application.credentials[:front_end_url]
    @recovery_url  = "#{@front_end_url}/passwords/new?recovery_token=#{recovery_token}"
    @login_url = "#{@front_end_url}/login"
    mail(to: @user.email, subject: 'Your password change request')
  end
end


