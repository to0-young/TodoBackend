class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :priority, :due_date, :completed
end

