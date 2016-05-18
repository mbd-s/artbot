class ArtsController < ApplicationController
  before_action :authenticate_admin!, :except => [:show]
  before_action :set_art, :except => [:index, :new, :create]

  def index
    @arts = Art.all
  end

  def new
    @art = Art.new
  end

  def create
    @art = Art.new(art_params)
    if @art.save
      flash[:success] = "New Artwork Added"
      redirect_to @art
    else
      flash[:error] = @art.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    render :show
  end

  def edit
    render :edit
  end

  def update
    if @art.update(art_params)
      flash[:success] = "Artwork Updated"
      redirect_to art_path(@art)
    else
      flash[:error] = @art.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @art.destroy
    flash[:warning] = "Artwork Deleted"
    redirect_to arts_path
  end


  private

    def art_params
      params.require(:art).permit(:title, :artist_id, :image, :year, :century, :medium)
    end

    def set_art
      @art = Art.find(params[:id])
    end

end
