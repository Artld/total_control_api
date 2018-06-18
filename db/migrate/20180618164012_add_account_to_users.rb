class AddAccountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :account, :integer, default: 0
  end
end
