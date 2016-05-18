require 'rails_helper'

RSpec.describe ArtsController, type: :controller do
  describe "GET #index" do
    context "is current_admin" do
      it "populates an array of artwork"
      it "renders the :index view"
    end
    context "is not current_admin" do
      it "doesn't render the :index view"
      it "renders "
    end
  end

  describe "GET #show" do
    context "is current_admin" do
      it "sets the selected art to @art"
      it "renders the :show template"
      it "shows edit/delete buttons"
    end
    context "is not current_admin" do
      it "sets the selected art to @art"
      it "renders the :show template"
    end
  end

  describe "GET #new" do
    context "is current_admin" do
      it "sets a new art to @art"
      it "renders the :new template"
    end
    context "is not current_admin" do
      it "doesn't render the :new template"
    end
  end

  describe "POST #create" do
    context "is current_admin && with valid attributes" do
      it "saves the new artwork in the database"
      it "renders the :show template of the newly added artwork"
    end
    context "is current_admin && with invalid attributes" do
      it "doesn't save the artwork in the database"
      it "re-renders the :new template"
    end
    context "is not current_admin" do
      it "doesn't save the artwork in the database"
    end
  end

  describe "GET #edit" do
    context "is current_admin" do
      it "sets the selected art to @art"
      it "renders the :edit template"
    end
    context "is not current_admin" do
      it "doesn't render the :edit template"
    end
  end

  describe "PATCH #update" do
    context "is current_admin && with valid attributes" do
      it "saves the editted artwork in the database"
      it "renders the :show template of the newly added artwork"
    end
    context "is current_admin && with invalid attributes" do
      it "doesn't save the edited artwork in the database"
      it "re-renders the :new template"
    end
    context "is not current_admin" do
      it "doesn't save the edited artwork in the database"
    end
  end

  describe "DELETE #destroy" do
    context "is current_admin" do
      it "sets the selected art to @art"
      it "removes the selected art from the database"
      it "renders the :index template"
    end
    context "is not current_admin" do
      it "cannot delete art from the database"
    end
  end

  end
end
