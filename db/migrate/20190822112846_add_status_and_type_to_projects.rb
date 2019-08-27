class AddStatusAndTypeToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :is_progress, :boolean, default: true
    add_column :projects, :is_fixed, :boolean, default: true
  end
end
