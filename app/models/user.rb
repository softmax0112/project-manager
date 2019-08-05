# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects_users, dependent: :destroy, class_name: 'Projects_User'
  has_many :projects, through: :projects_users, class_name: 'Project'

  validates :name, presence: true,
                   length: { minimum: 1, maximum: 50 },
                   format: { with: /[a-zA-Z\s]*/, message: 'Only letters allowed' }

  validates_inclusion_of :role, in: %w[admin user manager]

  mount_uploader :image, ImageUploader

  enum role: { user: 'user', admin: 'admin', manager: 'manager' }

  def active_for_authentication?
    super && enabled?
  end

  def inactive_message
    'Your account has currently been disabled, please contact website administrator.'
  end
end
