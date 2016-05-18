class QuestionsController < ApplicationController
before_action :authenticate_admin!
before_action :set_art, :only => [:new, :create]
before_action :set_question, :except => [:index, :new, :create]

  def index
    @questions = Question.all
    render :index
  end

  def new
    @question = Question.new
    render :new
  end

  def create
    @question = Question.create(question_params)
    @art.questions << @question
    if @question.save
      flash[:success] = "New Question Added"
      redirect_to art_path(@art)
    else
      flash[:error] = @question.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @question.update(question_params)
      redirect_to questions_path
    else

      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to question_path
  end

  private

  def set_art
    @art = Art.find(params[:art_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:text, :answer, :art_id)
  end

end
