class ArtsController < ApplicationController
  def index
    @arts = Art.all
  end
end
