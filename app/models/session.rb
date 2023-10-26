class Session < ApplicationRecord
  validates :expiration , presence: true

  belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "expiration", "id", "updated_at", "user_id"]
  end
end


