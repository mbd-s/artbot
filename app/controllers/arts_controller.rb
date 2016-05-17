class ArtsController < ApplicationController
  before_action :authenticate_admin!, :set_art

  def index
    @arts = Art.all
  end

  def new
    @art = Art.new
  end

  def create
    @art = Art.new(art_params)
    if @art.save
      redirect_to @art
    else
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
      redirect_to art_path(@art)
    end
  end

  def destroy

    @art.destroy

    redirect_to arts_path
  end

    private
    
      def set_art
        @art = Art.find(params[:id])
      end
      
      def art_params
        params.require(:art).permit(:title, :artist, :image, :year, :century, :medium)
      end
end
