class User < ApplicationRecord
  has_secure_password

  has_many :sessions, dependent: :destroy

  validates :first_name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :email, presence: true, uniqueness: true, length: { minimum: 8, maximum: 30 }
end

