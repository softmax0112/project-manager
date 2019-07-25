class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true,
                   length: { minimum: 5 },
                   format: { with: /^[a-zA-Z]*$/, message: 'Only letters allowed' }

  mount_uploader :image, ImageUploader

  def active_for_authentication?
    super && enabledend
  end
end
