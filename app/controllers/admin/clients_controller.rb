# frozen_string_literal: true

class Admin::ClientsController < ApplicationController
  before_action :set_admin_client, only: %i[show edit update destroy]

  # GET /manager/clients
  # GET /manager/clients.json
  def index
    @admin_clients = if params[:name]
                       Client.where('name LIKE ?', "%#{params[:name]}%").page(params[:page])
                     else
                       Client.page(params[:page])
                     end
    authorize @admin_clients
  end

  # GET /manager/clients/1
  # GET /manager/clients/1.json
  def show
    @projects = Project.where('client_id = ?', @admin_client.id).page(params[:page])
  end

  # GET /manager/clients/new
  def new
    @admin_client = Client.new
    authorize @admin_client
  end

  # GET /manager/clients/1/edit
  def edit; end

  # POST /manager/clients
  # POST /manager/clients.json
  def create
    @admin_client = Client.new(admin_client_params)
    authorize @admin_client

    redirect_to admin_client_path(@admin_client), notice: 'Client was successfully created'
  end

  # PATCH/PUT /manager/clients/1
  # PATCH/PUT /manager/clients/1.json
  def update
    respond_to do |format|
      if @admin_client.update(admin_client_params)
        format.html { redirect_to admin_client_path(@admin_client), notice: 'Client was successfully updated' }
        format.json { render :show, status: :ok, location: @admin_client }
      else
        format.html { render :edit }
        format.json { render json: @admin_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manager/clients/1
  # DELETE /manager/clients/1.json
  def destroy
    @admin_client.destroy
    respond_to do |format|
      format.html { redirect_to admin_clients_path, notice: 'Client was successfully destroyed' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_client
    @admin_client = Client.find(params[:id])
    authorize @admin_client
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_client_params
    params.require(:client).permit(:name, :affiliation)
  end
end
