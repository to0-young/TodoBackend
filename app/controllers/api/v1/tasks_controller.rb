class Api::V1::TasksController < ApplicationController

  def index
    tasks = Task.where(user_id: current_session.user_id)
    render json: tasks
  end
  def create

  end
end
