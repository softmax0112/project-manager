# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name, null: false, index: true
      t.string :affiliation
    end
  end
end
