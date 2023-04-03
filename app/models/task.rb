class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 1, maximum: 20 }
  validates :priority, presence: true, length: { minimum: 1, maximum: 20 }
  validates :due_date, presence: true, length: { minimum: 1, maximum: 40 }
end
