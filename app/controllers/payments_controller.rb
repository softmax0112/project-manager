# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_payment, only: %i[show edit update destroy]

  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.page(params[:page])
    authorize @payments
  end

  # GET /payments/1
  # GET /payments/1.json
  def show; end

  # GET /payments/new
  def new
    @payment = Payment.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /payments/1/edit
  def edit; end

  # POST /payments
  # POST /payments.json
  def create
    request.params[:payment][:creator_id] = current_user.id
    request.params[:payment][:project_id] = params[:project_id] unless request.params[:attachment].nil?
    request.params[:project_id] = params[:project_id]

    @payment = Payment.new(payment_params)

    respond_to do |format|
      if @payment.save
        format.html do
          authorize @payment
          redirect_to decide_project_path(params[:project_id]), notice: 'Payment was successfully created'
        end
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    request.params[:payment][:creator_id] = current_user.id
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payment
    @payment = Payment.find(params[:id])
    @project = Project.find(@payment.project_id)
    authorize @payment
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def payment_params
    params.require(:payment).permit(:amount, :project_id, :creator_id)
  end
end
