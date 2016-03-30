class AddPitureToToDoLists < ActiveRecord::Migration
  def change
    add_column :to_do_lists, :picture, :string
  end
end
