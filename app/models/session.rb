class Session < ApplicationRecord
  validates :expiration
  validates :token
end
