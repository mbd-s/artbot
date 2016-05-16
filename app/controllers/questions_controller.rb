class QuestionsController < ApplicationController
  before_action :set_art

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to art_path(@art)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_art
    @art = Art.find(params[:art_id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def question_params
    params.require(:question).allow(:text, :answer, :art_id)
  end

end
