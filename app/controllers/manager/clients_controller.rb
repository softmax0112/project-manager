# frozen_string_literal: true

class Manager::ClientsController < ApplicationController
  before_action :set_manager_client, only: %i[show edit update destroy]

  # GET /manager/clients
  # GET /manager/clients.json
  def index
    @manager_clients = if params[:name]
                         Client.where('name LIKE ?', "%#{params[:name]}%").page(params[:page])
                       else
                         Client.page(params[:page])
                       end
    authorize @manager_clients
  end

  # GET /manager/clients/1
  # GET /manager/clients/1.json
  def show; end

  # GET /manager/clients/new
  def new
    @manager_client = Client.new
    authorize @manager_client
  end

  # GET /manager/clients/1/edit
  def edit; end

  # POST /manager/clients
  # POST /manager/clients.json
  def create
    @manager_client = Client.new(manager_client_params)
    authorize @manager_client

    redirect_to manager_client_path(@manager_client), notice: 'Client was successfully created'
  end

  # PATCH/PUT /manager/clients/1
  # PATCH/PUT /manager/clients/1.json
  def update
    respond_to do |format|
      if @manager_client.update(manager_client_params)
        format.html { redirect_to manager_client_path(@manager_client), notice: 'Client was successfully updated' }
        format.json { render :show, status: :ok, location: @manager_client }
      else
        format.html { render :edit }
        format.json { render json: @manager_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manager/clients/1
  # DELETE /manager/clients/1.json
  def destroy
    @manager_client.destroy
    respond_to do |format|
      format.html { redirect_to manager_clients_path, notice: 'Client was successfully destroyed' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_manager_client
    @manager_client = Client.find(params[:id])
    authorize @manager_client
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def manager_client_params
    params.require(:client).permit(:name, :affiliation)
  end
end
