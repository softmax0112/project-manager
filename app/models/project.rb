class Project < ApplicationRecord
  belongs_to :user, foreign_key: 'manager_id'
  belongs_to :user, foreign_key: 'creator_id'
end
