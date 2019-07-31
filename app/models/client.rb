# frozen_string_literal: true

class Client < ApplicationRecord
  validates :name, presence: true,
                   length: { minimum: 1, maximum: 50 },
                   format: { with: /[a-zA-Z\s]*/, message: 'Only letters allowed' }
end
