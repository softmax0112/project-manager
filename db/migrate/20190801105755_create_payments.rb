# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.integer :amount
      t.belongs_to :project, foreign_key: true
      t.integer :creator_id, index: true

      t.timestamps
    end
  end
end
