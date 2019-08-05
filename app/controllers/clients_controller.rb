# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :set_client, only: %i[show edit update destroy]

  # GET /manager/clients
  # GET /manager/clients.json
  def index
    @clients = if params[:name]
                       Client.where('name LIKE ?', "%#{params[:name]}%").page(params[:page])
                     else
                       Client.page(params[:page])
                     end
    authorize @clients
  end

  # GET /manager/clients/1
  # GET /manager/clients/1.json
  def show
    @projects = @client.projects.page(params[:page])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_client
    @client = Client.find(params[:id])
    authorize @client
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def client_params
    params.require(:client).permit(:name, :affiliation)
  end
end
