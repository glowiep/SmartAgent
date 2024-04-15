class Api::V1::StatusesController < ApplicationController
  before_action :set_status, only: %i[show update destroy]

  # GET /statuses
  # GET /statuses.json
  def index
    render json: @statuses = Status.all
  end

  # GET /statuses/1
  # GET /statuses/1.json
  def show
  end

  # POST /statuses
  # POST /statuses.json
  def create
    @status = Status.new(status_params)

    if @status.save
      render :show, status: :created, location: @status
    else
      render json: @status.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /statuses/1
  # PATCH/PUT /statuses/1.json
  def update
    if @status.update(status_params)
      render :show, status: :ok, location: @status
    else
      render json: @status.errors, status: :unprocessable_entity
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @status.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_status
    @status = Status.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def status_params
    params.require(:status).permit(:description, :created_at)
  end
end
