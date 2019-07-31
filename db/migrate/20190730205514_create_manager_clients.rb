# frozen_string_literal: true

class CreateManagerClients < ActiveRecord::Migration[5.2]
  def change
    create_table :manager_clients do |t|
      t.string :name
      t.string :affiliation
    end
  end
end
