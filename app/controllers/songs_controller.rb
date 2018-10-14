class SongsController < ApplicationController
  def index
    if params[:artist_id]
      # artist_id comes from the nested route
      # Rails takes the parent resource's name and appends _id to it
      @songs = Artist.find(params[:artist_id]).songs
    else
      # accessing the index of all songs
      @songs = Song.all
    end
    
   rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Artist not found"
    redirect_to artists_path
  end

  def show
    @song = Song.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Song not found"

    if params[:artist_id]
      redirect_to artist_songs_path(params[:artist_id])
    else
      redirect_to songs_path
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end

