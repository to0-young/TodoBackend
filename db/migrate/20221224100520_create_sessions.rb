class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.datetime :expiration
      t.string :token

      t.timestamps
    end
    add_index :sessions, :token
  end
end
