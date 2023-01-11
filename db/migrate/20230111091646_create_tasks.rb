class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.integer :priority
      t.datetime :due_date

      t.integer :user_id

      t.timestamps
    end
    add_index :tasks, :user_id
  end
end
