class Api::V1::DirectChatsController < ApplicationController
  before_action :set_direct_chat, only: %i[ show update destroy ]

  # GET /direct_chats
  # GET /direct_chats.json
  def index
    if params[:sender_id] && params[:receiver_id]
      @direct_chats = DirectChat.where(
        '(sender_id = :sender_id AND receiver_id = :receiver_id) OR (sender_id = :receiver_id AND receiver_id = :sender_id)', 
        sender_id: params[:sender_id], 
        receiver_id: params[:receiver_id]
      )
    else
      @direct_chats = DirectChat.all
    end
    render json: @direct_chats
  end

  # GET /direct_chats/1
  # GET /direct_chats/1.json
  def show
  end

  # POST /direct_chats
  # POST /direct_chats.json
  def create
    @direct_chat = DirectChat.new(direct_chat_params)

    if @direct_chat.save
    #   ActionCable.server.broadcast(
    #   "direct_chat",
    #   @direct_chat
    # )
      render json: @direct_chat, status: :created
    else
      render json: @direct_chat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /direct_chats/1
  # PATCH/PUT /direct_chats/1.json
  def update
    if @direct_chat.update(direct_chat_params)
      render :show, status: :ok, location: @direct_chat
    else
      render json: @direct_chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /direct_chats/1
  # DELETE /direct_chats/1.json
  def destroy
    @direct_chat.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_direct_chat
      @direct_chat = DirectChat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def direct_chat_params
      params.require(:direct_chat).permit(:sender_id, :receiver_id, :message)
    end
end
