# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true,
                   length: { minimum: 5 },
                   format: { with: /[a-zA-Z\s]*/, message: 'Only letters allowed' }

  mount_uploader :image, ImageUploader

  enum role: { user: 'user', admin: 'admin', manager: 'manager' }

  def active_for_authentication?
    super && enabled
  end
end
