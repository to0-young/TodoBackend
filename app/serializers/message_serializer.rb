class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :user_id, :user, :created_at

  def user
    if object.user.present?
      UserSerializer.new(object.user).attributes
    else
      nil
    end
  end
end
