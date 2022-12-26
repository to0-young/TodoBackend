class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.datetime :expiration, null: false
      t.string :token, null: false

      # t.belongs_to :user
      # t.references :user
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :sessions, :token, unique: true
    add_index :sessions, :user_id
  end
end
