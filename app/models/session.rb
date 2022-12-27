class Session < ApplicationRecord
  validates :expiration , presence: true

  belongs_to :user
end


