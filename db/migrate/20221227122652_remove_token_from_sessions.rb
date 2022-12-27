class RemoveTokenFromSessions < ActiveRecord::Migration[7.0]
  def change
    remove_column :sessions, :token, :string
  end
end
