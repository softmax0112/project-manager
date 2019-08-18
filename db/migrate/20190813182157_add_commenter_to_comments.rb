# frozen_string_literal: true

class AddCommenterToComments < ActiveRecord::Migration[5.2]
  def change
    change_table :comments do |t|
      t.references :commenter
    end
  end
end
