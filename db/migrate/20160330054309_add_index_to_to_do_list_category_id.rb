class AddIndexToToDoListCategoryId < ActiveRecord::Migration
  def change
  	add_index :to_do_lists, [:user_id, :category_id]
  end
end
