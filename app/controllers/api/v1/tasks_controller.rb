class Api::V1::TasksController < ApplicationController
  before_action :authenticate!

  def index
    # params[:page]
    # params[:per_page]
    # tasks = Task.where(user_id: current_session.user_id)
    pagy, tasks = pagy(current_user.tasks.order(created_at: :asc), page: params[:page] , items: params[:per_page])
    render json: { pagy: pagy  , tasks: ActiveModelSerializers::SerializableResource.new(tasks), status: :ok }
  end

  def show
    task = Task.find(params[:id])
    render json: ActiveModelSerializers::SerializableResource.new(task).to_json, status: :ok
  end

  def create
    # task = current_session.user.tasks.new(params.permit(:title, :priority,  :description, :due_date))
    # task = Task.new(params.permit(:title, :priority,  :description, :due_date).merge(user_id: current_session.user_id))
    task = Task.new(params.permit(:title, :priority,  :description, :due_date))
    task.user_id = current_session.user_id

    if task.save
      render json: task, status: :created
    else
      render json: { errors: task.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    task = Task.find(params[:id])
    if task.update params.require(:task).permit(:title, :priority, :description, :due_date, :completed)
      render json: task, status: :ok
    else
      render json: { errors: "error" }, status: :unprocessable_entity
    end
  end


  def destroy
    task = current_user.tasks.find(params[:id])
    # task = Task.find_by(id: params[:id], user_id: current_session.user_id)
    task&.destroy
    render json: ActiveModelSerializers::SerializableResource.new(task).to_json, status: :ok
  end
end



