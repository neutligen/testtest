class AddColumnToToDoLists < ActiveRecord::Migration
  def change
    add_column :to_do_lists, :schedule_date, :date
    add_column :to_do_lists, :schedule_time, :time
    add_column :to_do_lists, :comment, :text
    add_column :to_do_lists, :priority_flg, :string
    add_column :to_do_lists, :ending_flg, :boolean, default: false
    add_column :to_do_lists, :reminder_mail, :boolean, default: false
  end
end
