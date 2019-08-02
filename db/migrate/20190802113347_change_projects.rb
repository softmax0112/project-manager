class ChangeProjects < ActiveRecord::Migration[5.2]
  def change
    change_column_default :projects, :total_payment, 0
    change_column_default :projects, :hours_spent, 0
  end
end
