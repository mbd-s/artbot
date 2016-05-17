Rails.application.routes.draw do
  root to: "arts#index"
  devise_for :admins
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get "/questions", to: "questions#index"

  resources :artist, except: [:show, :index]

  resources :arts do
    resources :questions, except: [:show, :index]
  end



end
