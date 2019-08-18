# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :set_client, only: %i[show edit update destroy]

  def index
    @clients = Client.search(params[:name]).page(params[:page])
    authorize @clients
  end

  def show
    @projects = @client.projects.page(params[:page])
  end

  private

  def set_client
    @client = Client.find(params[:id])
    authorize @client
  end

  def client_params
    params.require(:client).permit(:name, :affiliation)
  end
end
