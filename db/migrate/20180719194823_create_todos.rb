class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table do |t|
      t.string :day
      t.string :description
      t.integer :user_id
    end
  end
end
