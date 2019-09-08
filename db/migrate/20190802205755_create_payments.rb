# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.integer :amount, null: false
      t.belongs_to :project, foreign_key: true
      t.references :creator, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
