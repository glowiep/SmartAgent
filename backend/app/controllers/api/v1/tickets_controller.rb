class Api::V1::TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show update destroy]

  # GET api/v1/tickets
  # GET api/v1/tickets.json
  def index
    @tickets = Ticket.order(created_at: :desc)
    render json: @tickets.as_json(include: {
                                    conversations: {
                                      methods: :attachments_urls
                                    }
                                  })
  end

  # GET api/v1/tickets/1
  # GET api/v1/tickets/1.json
  def show
    ticket = Ticket.find(params[:id])
    render json: ticket.as_json(include: {
                                  conversations: {
                                    methods: :attachments_urls
                                  }
                                })
  end

  # POST api/v1/tickets
  # POST api/v1/tickets.json
  def create
    @ticket = Ticket.new(ticket_params.except(:body, :attachments))
  
    if @ticket.save
      @ticket.conversations.create!(body: ticket_params[:body], from_customer: true)
      if params[:attachments]
        params[:attachments].each do |attachment|
          @ticket.attachments.attach(attachment)
        end
      end
      ActionCable.server.broadcast('tickets', @ticket)
      render json: @ticket, status: :created
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end
  # POST api/v1/tickets/1/respond
  # POST api/v1/tickets/1/respond.json
  def respond
    @ticket = Ticket.find(params[:ticket_id])
    response = params[:response]
    attachments = params[:attachments]

    return render json: { error: 'Response is missing' }, status: :unprocessable_entity if response.blank?

    ApplicationMailer.ticket_response(@ticket, response, attachments).deliver_now

    render json: { message: 'Response sent' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Ticket not found' }, status: :not_found
  rescue StandardError => e
    render json: { error: "Error sending email: #{e.message}" }, status: :internal_server_error
  end

  # PATCH/PUT api/v1/tickets/1
  # PATCH/PUT api/v1/tickets/1.json
  # PATCH/PUT api/v1/tickets/1
  # PATCH/PUT api/v1/tickets/1.json
  def update
    if params[:status_id]
      status = Status.find_by(id: params[:status_id])
      return render json: { error: 'Status not found' }, status: :not_found unless status

      @ticket.status = status

    end
    if params[:agent_id]
      agent = Agent.find_by(id: params[:agent_id])
      return render json: { error: 'Agent not found' }, status: :not_found unless agent

      @ticket.agent = agent
    end
    if @ticket.update(ticket_params)
      render json: @ticket, status: :ok
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # DELETE api/v1/tickets/1
  # DELETE api/v1/tickets/1.json
  def destroy
    @ticket.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def ticket_params
    params.require(:ticket).permit(:from_email, :customer_name, :title, :agent_id, :status_id, :body)
  end
end
