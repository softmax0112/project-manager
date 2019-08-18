# frozen_string_literal: true

class CreateTimeLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :time_logs do |t|
      t.belongs_to :project, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :hours, null: false

      t.timestamps
    end
  end
end
