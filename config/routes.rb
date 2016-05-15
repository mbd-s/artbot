Rails.application.routes.draw do
  root to: "arts#index"
  devise_for :admins
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resources :arts
end
