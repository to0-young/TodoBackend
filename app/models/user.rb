class User < ApplicationRecord
  has_secure_password
  mount_uploader :avatar, AvatarUploader

  has_many :sessions, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :first_name, presence: true, length: { minimum: 1, maximum: 15 }
  validates :last_name, presence: true, length: { minimum: 1, maximum: 15 }
  validates :email, presence: true, uniqueness: true, length: { minimum: 8, maximum: 30 }

  def self.ransackable_attributes(auth_object = nil)
    ["avatar", "created_at", "email", "email_confirmed", "first_name", "id", "last_name", "password_digest", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["sessions", "tasks", "message"] # додайте всі асоціації, які ви хочете використовувати для пошуку
  end
end
