class Api::V1::TasksController < ApplicationController

  def index
    # tasks = Task.where(user_id: current_session.user_id)
    tasks = current_user.tasks
    render json: ActiveModelSerializers::SerializableResource.new(tasks).to_json, status: :ok
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

  # def update
  #   task = Task.find(params[:id])
  #   if task.update params.permit(:title, :priority, :dueDate )
  #     render json: task, status: :ok
  #   else
  #     render json: { errors: task.errors.messages }, status: :unprocessable_entity
  #   end
  # end
  #

  def destroy
    task = current_user.tasks.find(params[:id])
    # task = Task.find_by(id: params[:id], user_id: current_session.user_id)
    task&.destroy
    render json: ActiveModelSerializers::SerializableResource.new(task).to_json, status: :ok
  end
end



