class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :end_users, :self_introduction, true
  end

  def down
    change_column_null :end_users, :self_introduction, false
  end
end
