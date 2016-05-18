class ArtsController < ApplicationController
  before_action :authenticate_admin!, :except => [:show]

  def index
    @arts = Art.all
  end

  def new
    @art = Art.new
  end

  def create
    @art = Art.new(art_params)
    if @art.save
      flash[:notice] = "New Art Created!"
      redirect_to @art
    else
      flash[:error] = @art.errors.full_messages.join(", \n")
      render :new
    end
  end

  def show
    @art = Art.find(params[:id])
    render :show
  end

  def edit
    @art = Art.find(params[:id])
    render :edit
  end

  def update
    art = Art.find(params[:id])

    if art.update(art_params)
      redirect_to art_path(art)
    end
  end

  def destroy
    art = Art.find(params[:id])

    art.destroy

    redirect_to arts_path
  end


  private
    def art_params
      params.require(:art).permit(:title, :artist_id, :image, :year, :century, :medium)
    end
end
