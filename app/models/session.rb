class Session < ApplicationRecord
  validates  :expiration , presence: true
  validates :token , presence: true

  belongs_to :user
end


