class ArtistsController < ApplicationController

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      redirect_to arts_path
    else
      render :new
    end
  end


private

  def artist_params
    params.require(:artist).permit(:name, :birth, :death, :nationality)
  end

  def set_artist
    @artist = Artist.find(params[:id])
  end

end
