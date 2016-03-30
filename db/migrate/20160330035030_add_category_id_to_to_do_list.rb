class AddCategoryIdToToDoList < ActiveRecord::Migration
  def change
    add_reference :to_do_lists, :category, index: true, foreign_key: true
  end
end
