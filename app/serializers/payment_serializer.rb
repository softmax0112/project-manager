# frozen_string_literal: true

class PaymentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :amount

  has_many :comments
  belongs_to :project
  belongs_to :creator, record_type: :user
end
