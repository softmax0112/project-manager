# frozen_string_literal: true

class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.string :filename, null: false
      t.belongs_to :project, index: true, foreign_key: true

      t.timestamps
    end
  end
end
