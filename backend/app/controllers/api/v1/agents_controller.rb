class Api::V1::AgentsController < ApplicationController
  before_action :set_agent, only: %i[show update destroy]

  # GET /agents
  # GET /agents.json
  def index
    render json: @agents = Agent.all
  end

  # GET /agents/1
  # GET /agents/1.json
  def show
  end

  # POST /agents
  # POST /agents.json
  def create
    @agent = Agent.new(agent_params)

    if @agent.save
      render :show, status: :created, location: @agent
    else
      render json: @agent.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /agents/1
  # PATCH/PUT /agents/1.json
  def update
    if @agent.update(agent_params)
      render :show, status: :ok, location: @agent
    else
      render json: @agent.errors, status: :unprocessable_entity
    end
  end

  # DELETE /agents/1
  # DELETE /agents/1.json
  def destroy
    @agent.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_agent
    @agent = Agent.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def agent_params
    params.require(:agent).permit(:username, :password)
  end
end
