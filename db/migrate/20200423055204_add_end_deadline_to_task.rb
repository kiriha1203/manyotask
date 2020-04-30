class AddEndDeadlineToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :end_deadline, :date
  end
end
