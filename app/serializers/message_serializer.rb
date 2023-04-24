class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :user_id, :user

  def user
    UserSerializer.new(object.user).attributes
  end
end

