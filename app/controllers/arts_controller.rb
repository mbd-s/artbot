class ArtsController < ApplicationController
  before_action :authenticate_admin!

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
    @art = target_art
    render :show
  end

  def edit
    @art = target_art
    render :edit
  end

  def update
    art = target_art


    if art.update(art_params)
      redirect_to art_path(art)
    end
  end

  def destroy
    art = target_art

    art.destroy

    redirect_to arts_path
  end

    private
      def target_art
        Art.find(params[:id])
      end
      def art_params
        params.require(:art).permit(:title, :artist, :image, :year, :century, :medium)
      end
end
