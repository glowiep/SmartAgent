class Api::V1::ConversationsController < ApplicationController
  before_action :set_conversation, only: %i[show update destroy]

  # GET /conversations
  # GET /conversations.json
  def index
    @conversations = Conversation.all
    render json: @conversations
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
    conversation = Conversation.find(params[:id])
    render json: conversation.as_json.merge({
                                              attachments: conversation.attachments.map do |attachment|
                                                url_for(attachment)
                                              end
                                            })
  end

  # POST /conversations
  # POST /conversations.json
  def create
    @ticket = Ticket.find(params[:ticket_id])
    @response = params[:response]
    @attachments = params[:attachments]

   if conversation = @ticket.conversations.create!(
      body: @response,
      from_customer: false
    )

    @attachments.each do |attachment|
      filename = attachment.original_filename
      file_content = File.read(attachment.tempfile)
      conversation.attachments.attach(io: StringIO.new(file_content), filename: filename)
    end

    # ActionCable.server.broadcast(
    #   "TicketChannel_#{@ticket.id}",
    #   ticket: @ticket.as_json(include: :conversations)
    # )
      render :show, status: :created, location: @conversation
    else
      render json: @conversation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /conversations/1
  # PATCH/PUT /conversations/1.json
  def update
    if @conversation.update(conversation_params)
      render :show, status: :ok, location: @conversation
    else
      render json: @conversation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    @conversation.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def conversation_params
    params.require(:conversation).permit(:ticket_id, :body, :from_customer)
  end
end
