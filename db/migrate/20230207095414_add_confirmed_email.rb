class AddConfirmedEmail < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email_confirmed, :boolean, default: false
  end
end
