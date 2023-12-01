class MessagesController < ApplicationController
  # GET /messages or /messages.json
  def index
    messages = Message.all
    render json: messages
  end

  # POST /messages or /messages.json
  def create
    message = Message.new(message_params)
    message.user_id = current_user.id

    if message.save
      render json: ActiveModelSerializers::SerializableResource.new(message).to_json, status: :ok
    else
      render json: { errors: message.errors }, status: :unprocessable_entity
    end
  end


  # Delete a message by the current user
  def destroy
    message = current_user.messages.find(params[:id])
    message&.destroy
    render json: ActiveModelSerializers::SerializableResource.new(message).to_json, status: :ok
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:body)
    end
end
