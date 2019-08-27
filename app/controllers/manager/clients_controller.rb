# frozen_string_literal: true

class Manager::ClientsController < ApplicationController
  before_action :set_manager_client, only: %i[show edit update destroy]

  def index
    @manager_clients = Client.search(params[:name]).page(params[:page])
    authorize @manager_clients
  end

  def show
    @projects = @manager_client.projects.page(params[:page])
  end

  def new
    @manager_client = Client.new
    authorize @manager_client
  end

  def edit; end

  def create
    @manager_client = Client.new(manager_client_params)
    authorize @manager_client

    if @manager_client.save
      redirect_to manager_client_path(@manager_client), notice: 'Client was successfully created'
    else
      render :new
    end
  end

  def update
    if @manager_client.update(manager_client_params)
      redirect_to manager_clients_path, notice: 'Client was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @manager_client.destroy
    redirect_to manager_clients_path, notice: 'Client was successfully destroyed'
  end

  private

  def set_manager_client
    @manager_client = Client.includes(:projects).find(params[:id])
    authorize @manager_client
  end

  def manager_client_params
    params.require(:client).permit(:name, :affiliation)
  end
end
