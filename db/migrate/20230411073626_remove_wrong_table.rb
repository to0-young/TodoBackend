class RemoveWrongTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :messeges
  end
end
