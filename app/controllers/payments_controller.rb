# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[show edit update destroy]

  def index
    @payments = Payment.page(params[:page])
    authorize @payments
  end

  def show
    @comments = @payment.comments.order('created_at DESC').limit(Payment::COMMENTS_PREVIEW_COUNT)
    @comment = Comment.new
  end

  def new
    @payment = Payment.new

    respond_to do |format|
      format.js
    end
  end

  def edit; end

  def create
    @payment = Payment.new(payment_params)

    respond_to do |format|
      if @payment.save
        @payment.project.payments << @payment
        format.js
      else
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @project = @payment.project
    @project.payments.destroy(params[:id])
    redirect_to decide_project_path(@project), notice: 'Payment was successfully destroyed'
  end

  private

  def set_payment
    @payment = Payment.find(params[:id])
    authorize @payment
  end

  def payment_params
    params.require(:payment).permit(:amount, :project_id, :creator_id)
  end
end
