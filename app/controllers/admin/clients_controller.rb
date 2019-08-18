# frozen_string_literal: true

class Admin::ClientsController < ApplicationController
  before_action :set_admin_client, only: %i[show edit update destroy]

  def index
    @admin_clients = Client.search(params[:name]).page(params[:page])
    authorize @admin_clients
  end

  def show
    @projects = @admin_client.projects.page(params[:page])
  end

  def new
    @admin_client = Client.new
    authorize @admin_client
  end

  def edit; end

  def create
    @admin_client = Client.new(admin_client_params)
    authorize @admin_client

    if @admin_client.save
      redirect_to admin_client_path(@admin_client), notice: 'Client was successfully created'
    else
      render :new
    end
  end

  def update
    if @admin_client.update(admin_client_params)
      redirect_to admin_client_path(@admin_client), notice: 'Client was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @admin_client.destroy
    redirect_to admin_clients_path, notice: 'Client was successfully destroyed'
  end

  private

  def set_admin_client
    @admin_client = Client.find(params[:id])
    authorize @admin_client
  end

  def admin_client_params
    params.require(:client).permit(:name, :affiliation)
  end
end
