class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :category_name
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :categories, [:user_id, :created_at]
  end
end
