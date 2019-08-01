# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.integer :hours_spent
      t.integer :total_payment
      t.integer :manager_id, index: true
      t.integer :creator_id, index: true

      t.timestamps
    end
  end
end
