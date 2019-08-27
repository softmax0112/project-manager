# frozen_string_literal: true

class Api::V1::PaymentsController < Api::V1::ApiController
  before_action :set_payment, only: %i[show]
  before_action :auth_management

  def index
    @payments = Payment.fetch_project_payments(params[:project_id]).includes(:project, :creator).page(params[:page])
    success(get_json(@payments))
  end

  def show
    success(get_json(@payment))
  end

  private

  def set_payment
    @payment = Payment.find(params[:id])
  end

  def get_json(payments)
    PaymentSerializer.new(payments).serialized_json
  end
end
