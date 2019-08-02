# frozen_string_literal: true

json.array! @payments, partial: 'payments/payment', as: :payment
