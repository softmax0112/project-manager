class CreateTimeLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :time_logs do |t|
      t.belongs_to :project, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.integer :hours, null: false

      t.timestamps
    end
  end
end
