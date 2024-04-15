class SessionsController < ApplicationController
  # POST /login
  def create
    @agent = Agent.find_by(email: params[:email])
    if @agent && @agent.authenticate(params[:password])
      session[:agent_id] = @agent.id
      render json: { logged_in: true, agent_id: @agent.id, full_name: @agent.full_name }, status: :created
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  # DELETE /logout
  def destroy
    session[:agent_id] = nil
    render json: { logged_in: false }, status: :ok
  end
end
