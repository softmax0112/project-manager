# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :comment
      t.string :commenter
      t.string :commentable_type
      t.integer :commentable_id
      t.timestamps
    end
    add_index :comments, [:commentable_type, :commentable_id]
  end
end
