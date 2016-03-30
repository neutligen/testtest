class CreateToDoLists < ActiveRecord::Migration
  def change
    create_table :to_do_lists do |t|
      t.text :title
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :to_do_lists, [:user_id, :created_at]
  end
end
