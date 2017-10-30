class NotesController < ApplicationController
  before_action :require_logged_in

  def create
    note = Note.new(note_params)
    note.track_id = params[:track_id]
    note.user_id = current_user.id
    note.save
    redirect_to track_url(params[:track_id])
  end

  def destroy
    note = Note.find_by(id: params[:id])
    if note.user_id == current_user.id
      note.destroy
      redirect_to track_url(params[:track_id])
    else
      render text: 'You do not have permission to delete that note',
        status: 403
    end
  end

  private

  def note_params
    params.require(:note).permit(:text)
  end
end
