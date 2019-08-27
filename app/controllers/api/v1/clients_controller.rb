# frozen_string_literal: true

class Api::V1::ClientsController < Api::V1::ApiController
  before_action :set_client, only: %i[show update destroy]
  before_action :auth_management, only: %i[create update destroy]

  def index
    @clients = Client.search(params[:search]).includes(:projects).page(params[:page])
    success(get_json(@clients))
  end

  def show
    success(get_json(@client))
  end

  def update
    if @client.update(client_params)
      success(get_json(@client))
    else
      failure(@client.errors)
    end
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      success(get_json(@client), :created)
    else
      failure(@client.errors)
    end
  end

  def destroy
    @client.destroy
    success('Successfully destroyed')
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def get_json(clients)
    ClientSerializer.new(clients).serialized_json
  end

  def client_params
    params.require(:client).permit(:name, :affiliation)
  end
end
