class Project < ApplicationRecord
  belongs_to :manager
  belongs_to :user
end
