class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.integer :hours_spent
      t.integer :total_payment
      t.references :manager, foreign_key: true
      t.refernces :user
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
