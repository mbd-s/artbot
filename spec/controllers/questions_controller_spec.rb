require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

    it "blocks unauthenticated access" do
      sign_in nil

      get :index

      expect(response).to redirect_to(new_user_session_path)
    end

    it "allows authenticated access" do
      sign_in

      get :index

      expect(response).to be_success
    end

  describe "#index" do
    before do
      get :index
    end

    it "assigns @questions" do
      all_questions = Question.all
      expect(assigns(:questions)).to eq(all_questions)
    end

    it "renders :index view" do
      expect(response).to render_template(:index)
    end

  end
end
