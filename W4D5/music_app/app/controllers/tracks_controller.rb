class TracksController < ApplicationController
  before_action :require_logged_in

  def new
    @album = Album.find_by(id: params[:album_id])
    @track = Track.new(album_id: params[:album_id])
    @albums = Album.all
    render :new
  end

  def create
    track = Track.new(track_params)
    if track.save
      redirect_to track_url(track.id)
    else
      flash[:errors] ||= []
      flash[:errors].concat(track.errors.full_messages)
      redirect_to new_album_track_url
    end
  end

  def show
    @track = Track.find_by(id: params[:id])
    if @track
      @album = Album.find_by(id: @track.album_id)
      render :show
    else
      redirect_to bands_url
    end
  end

  def edit
    @track = Track.find_by(id: params[:id])
    if @track
      @album = Album.find_by(id: @track.album_id)
      @albums = Album.all
      render :edit
    else
      redirect_to bands_url
    end
  end

  def update
    track = Track.find_by(id: params[:id])
    if track.update(track_params)
      redirect_to track_url(track.id)
    else
      flash[:errors] ||= []
      flash[:errors].concat(track.errors.full_messages)
      redirect_to edit_track_url(track)
    end
  end

  def destroy
    track = Track.find_by(id: params[:id])
    if track
      album = Album.find_by(id: track.album_id)
      track.destroy
      redirect_to album_url(album.id)
    else
      redirect_to bands_url
    end
  end

  def track_params
    params.require(:track).permit(:title, :album_id, :ord, :bonus, :lyrics)
  end
end
