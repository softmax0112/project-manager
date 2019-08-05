# frozen_string_literal: true

class CreateJoinTableUsersProjects < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :projects do |t|
      t.index %i[user_id project_id], unique: true
      t.index %i[project_id user_id], unique: true
    end
  end
end
