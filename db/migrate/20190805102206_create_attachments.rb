class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.string :filename
      t.belongs_to :project, foreign_key: true

      t.timestamps
    end
  end
end
