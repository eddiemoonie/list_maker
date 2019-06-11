class AddPassConfirmToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :pass_confirm, :password_digest
  end
end
