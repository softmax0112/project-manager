# frozen_string_literal: true

class Client < ApplicationRecord
  validates :name, presence: true,
                   length: { maximum: 50 },
                   format: { with: /[a-zA-Z\s]*/, message: 'Only letters allowed' }

  validates :affiliation, length: { maximum: 50 }
  has_many :projects, dependent: :destroy

  def self.search(term)
    clients = self
    clients = clients.where('name LIKE ?', "%#{term}%") if term.present?
    clients
  end
end
