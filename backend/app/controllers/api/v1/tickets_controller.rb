class Api::V1::TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show update destroy]

  # GET api/v1/tickets
  # GET api/v1/tickets.json
  def index
    @tickets = Ticket.order(status_id: :asc, title: :asc, created_at: :desc)
    render json: @tickets.as_json(include: {
                                    conversations: {
                                      methods: :attachments_urls
                                    },
                                    agent: { 
                                      only: [:id, :full_name] 
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
                                  },
                                  agent: { 
                                    only: [:id, :full_name] 
                                  }
                                })
  end

  # POST api/v1/tickets
  # POST api/v1/tickets.json
  def create
    @ticket = Ticket.new(ticket_params.except(:body, :attachments))
    puts "Ticket created! #{ticket_params}"

    if @ticket.save
      conversation = @ticket.conversations.create!(body: ticket_params[:body], from_customer: true)
      if params[:ticket][:attachments]
        puts "Attachments found! #{params[:ticket][:attachments]}"
        params[:ticket][:attachments].each do |attachment|
          conversation.attachments.attach(attachment)
        end
      end
      ActionCable.server.broadcast('tickets', @ticket.as_json(include: {
        conversations: {
          methods: :attachments_urls
        },
        agent: { 
          only: [:id, :full_name] 
        }
      }))
      render json: @ticket.as_json(include: {
        conversations: {
          methods: :attachments_urls
        },
        agent: { 
          only: [:id, :full_name] 
        }
      }), status: :created
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # POST api/v1/tickets/respond { ticket_id: 1, response: 'Response'}
  def respond
    @ticket = Ticket.includes(:conversations).find(params[:ticket_id])

    response = params[:response]
    attachments = params[:attachments] ? params[:attachments].values : []

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
      ActionCable.server.broadcast('tickets', @ticket.as_json(include: {
        conversations: {
          methods: :attachments_urls
        },
        agent: { 
          only: [:id, :full_name]
        }
      }))
      render json: @ticket, status: :ok
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # DELETE api/v1/tickets/1
  # DELETE api/v1/tickets/1.json
  def destroy
    @ticket = Ticket.find(params[:id])
   if @ticket.destroy!
    ActionCable.server.broadcast('tickets', { id: @ticket.id, delete: true })
    render json: { message: 'Ticket deleted' }, status: :ok
   else
    render json: { error: 'Ticket not found' }, status: :not_found
   end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def ticket_params
    params.require(:ticket).permit(:from_email, :customer_name, :title, :agent_id, :status_id, :body, attachments: [])
  end
end
