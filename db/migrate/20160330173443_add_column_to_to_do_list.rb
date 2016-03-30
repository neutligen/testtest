class AddColumnToToDoList < ActiveRecord::Migration
  def change
    add_column :to_do_lists, :schedule_sta, :datetime
    add_column :to_do_lists, :schedule_end, :datetime
  end
end
