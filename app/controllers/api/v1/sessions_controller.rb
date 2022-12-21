class Api::V1::SessionsController < ApplicationController
  #
  # def index
  #   sessions = User.all
  #   render json: sessions
  # end
  def show
    # sessions = User.find(params[:id])
    # render json: sessions, except: :password
  end
  def create
    p "qwet1"
    p "qwet2"
    p "qwet3"
  end
  def destroy
    # sessions = sessions.find(params[:id])
    # sessions.destroy
  end
end
