class Message < ApplicationRecord
  after_create_commit { broadcast_message }
  after_destroy_commit { broadcast_delete }
  belongs_to :user

  private

  def broadcast_message
    ActionCable.server.broadcast('MessagesChannel',
      ActiveModelSerializers::SerializableResource.new(self))
  end
  def broadcast_delete
    ActionCable.server.broadcast "MessagesChannel", {
      id: id,
      type: "message_deleted" }
  end

  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "due_date", "id", "updated_at", "user_id"]
  end
end
