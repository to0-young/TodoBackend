class SessionSerializer < ActiveModel::Serializer
  attributes :id, :expiration, :user

  def user
    UserSerializer.new(object.user).attributes
  end
end
