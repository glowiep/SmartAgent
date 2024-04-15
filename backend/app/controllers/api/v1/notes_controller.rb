class Api::V1::NotesController < ApplicationController
  before_action :set_note, only: %i[ show update destroy ]

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all
    render json: @notes
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)

    if @note.save
      ActionCable.server.broadcast('notes_channel', @note)
      render json: @note 
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    if @note.update(note_params)
      render :show, status: :ok, location: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:ticket_id, :body)
    end
end
