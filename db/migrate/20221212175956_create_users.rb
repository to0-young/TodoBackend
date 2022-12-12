class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :password_digest
      t.string8 :email
      t.string30 :email
      t.string3 :first_name
      t.string30 :first_name
      t.string3 :last_name
      t.string30 :last_name

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
