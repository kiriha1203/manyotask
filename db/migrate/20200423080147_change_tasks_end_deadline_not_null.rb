class ChangeTasksEndDeadlineNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :end_deadline, false
  end
end
