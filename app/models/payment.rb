class Payment < ApplicationRecord
  belongs_to :projects, optional: true

  validates :amount, presence: true
  validates :creator_id, presence: true
  validates :project_id, presence: true
  validates_numericality_of :amount, lesser_than: 99999999, greater_than: 0
end
