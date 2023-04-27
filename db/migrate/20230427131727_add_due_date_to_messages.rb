class AddDueDateToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :due_date, :datetime
  end
end
