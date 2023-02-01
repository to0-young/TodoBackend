class ApplicationController < ActionController::Base
  include Pagy::Backend

  skip_before_action :verify_authenticity_token
  rescue_from JWT::ExpiredSignature, with: :session_expired!
  rescue_from JWT::DecodeError, with: :not_authorized!

  def current_session
    @current_session ||= begin
      token = cookies[:session]
      return nil if token.nil?
      decoded_token = JWT.decode(token, Rails.application.credentials[:jwt_secret], true, { algorithm: 'HS256' })
      session_id = decoded_token[0]['session_id']
      Session.where('expiration > ?', DateTime.now).find_by_id(session_id)
    end
  end

  def current_user
    @current_user ||= current_session&.user || authorized_user
  end
  def authorized_user
    token = request.headers['Authorization']
    return nil if token.nil?
    binding.pry
    decoded_token =  JWT.decode(token, Rails.application.credentials[:jwt_secret], true, { algorithm: 'HS256' })

  end

  def authenticate!
    not_authorized! if current_session.blank?
  end

  def not_authorized!
    render json: { message: 'JWT decode error' }, status: 401
  end

  def session_expired!
    render json: { message: 'JWT session expired' }, status: 401
  end

  def session_empty!
    render json: { message: 'JWT session is empty' }, status: 401
  end
end

