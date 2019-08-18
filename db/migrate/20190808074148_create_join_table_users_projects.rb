# frozen_string_literal: true

class CreateJoinTableUsersProjects < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :projects do |t|
      t.belongs_to :user, index: true
      t.belongs_to :project, index: true
    end
  end
end
