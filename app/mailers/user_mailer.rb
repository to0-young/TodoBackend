class UserMailer < ApplicationMailer
  default from: Rails.application.credentials[:support_email]

  def recover_email
    @user = params[:user]
    exp_payload = { user_id: @user.id }
    recovery_token = JWT.encode(exp_payload, Rails.application.credentials[:jwt_secret], 'HS256')
    @front_end_url = Rails.application.credentials[:front_end_url]
    @recovery_url = "#{@front_end_url}/passwords/new?recovery_token=#{recovery_token}"
    @login_url = "#{@front_end_url}/login"
    mail(to: @user.email, subject: 'Your password change request' )
  end

  def confirm_email
    @user = params[:user]
    set_payload = { user_id: @user.id }
    confirm_token = JWT.encode(set_payload, Rails.application.credentials[:jwt_secret], 'HS256')
    @front_end_url = Rails.application.credentials[:front_end_url]
    @confirm_url = "#{@front_end_url}/confirm_email?confirm_token=#{confirm_token}"
    mail(to: @user.email, subject: 'Your email confirm request')
  end
end


