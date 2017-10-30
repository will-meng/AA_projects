class AlbumsController < ApplicationController
  before_action :require_logged_in

  def new
    @band = Band.find_by(id: params[:band_id])
    @album = Album.new(band_id: params[:band_id])
    @bands = Band.all
    render :new
  end

  def create
    album = Album.new(album_params)
    if album.save
      redirect_to album_url(album.id)
    else
      flash[:errors] ||= []
      flash[:errors].concat(album.errors.full_messages)
      redirect_to new_band_album_url(album.band_id)
    end
  end

  def show
    @album = Album.find_by(id: params[:id])
    if @album
      @band = Band.find_by(id: @album.band_id)
      render :show
    else
      redirect_to bands_url
    end
  end

  def edit
    @album = Album.find_by(id: params[:id])
    if @album
      @band = Band.find_by(id: @album.band_id)
      @bands = Band.all
      render :edit
    else
      redirect_to album_url(@album.id)
    end
  end

  def update
    album = Album.find_by(id: params[:id])
    if album.update(album_params)
      redirect_to album_url(album.id)
    else
      flash[:errors] ||= []
      flash[:errors].concat(album.errors.full_messages)
      redirect_to edit_album_url(album.id)
    end
  end

  def destroy
    album = Album.find_by(id: params[:id])
    if album
      band = Band.find_by(id: album.band_id)
      album.destroy
      redirect_to band_url(band.id)
    else
      redirect_to bands_url
    end
  end

  private

  def album_params
    params.require(:album).permit(:title, :band_id, :live, :year)
  end

end
