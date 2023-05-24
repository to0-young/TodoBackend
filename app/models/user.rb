class User < ApplicationRecord
  has_secure_password
  mount_uploader :avatar, AvatarUploader

  has_many :sessions, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :message, dependent: :destroy

  validates :first_name, presence: true, length: { minimum: 1, maximum: 15 }
  validates :last_name, presence: true, length: { minimum: 1, maximum: 15 }
  validates :email, presence: true, uniqueness: true, length: { minimum: 8, maximum: 30 }
end

