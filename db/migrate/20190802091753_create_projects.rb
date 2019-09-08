# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.integer :hours_spent, default: 0, lesser_than: 0
      t.integer :total_payment, default: 0, lesser_than: 0
      t.references :manager, index: true, foreign_key: { to_table: :users }
      t.references :creator, index: true, foreign_key: { to_table: :users }
      t.belongs_to :client, index: true, foreign_key: true

      t.timestamps
    end
  end
end
