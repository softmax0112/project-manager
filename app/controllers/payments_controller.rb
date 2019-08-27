# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[show edit update destroy]

  def show
    @comments = @payment.comments.order('created_at DESC').includes(:commenter).limit(Payment::COMMENTS_PREVIEW_COUNT)
    @comment = Comment.new
  end

  def edit; end

  def create
    @payment = Payment.new(payment_params)

    respond_to do |format|
      if @payment.save
        @payment.project.payments << @payment
        format.js
      else
        format.js do
          @payment.errors.any?
          @payment.errors.each do |key, value|
          end
        end
      end
    end
  end

  def update
    if @payment.update(payment_params)
      redirect_to decide_project_path(@payment.project.id), notice: 'Payment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project = @payment.project
    @project.payments.destroy(params[:id])
    redirect_to decide_project_path(@project), notice: 'Payment was successfully destroyed'
  end

  private

  def set_payment
    @payment = Payment.includes(:creator, :project).find(params[:id])
    authorize @payment
  end

  def payment_params
    params.require(:payment).permit(:amount, :project_id, :creator_id)
  end
end
