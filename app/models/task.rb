class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 3, maximum: 20 }
  validates :priority, presence: true, length: { minimum: 1, maximum: 20 }
  validates :due_date, presence: true, length: { minimum: 1, maximum: 40 }

  def self.ransackable_attributes(auth_object = nil)
    ["completed", "created_at", "description", "due_date", "id", "priority", "title", "updated_at", "user_id"]
  end
end
