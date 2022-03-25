Rails.application.routes.draw do

  resources :data_requests do
    member do
      post "fill"
      post "cancel"
    end

    resources :attachments
  end

  ## LOGIN AND OUT
  get "logout" => "sessions#destroy", as:  "logout"
  get "login" => "sessions#new", as:  "login"
  get "invalid_login" => "sessions#invalid_login", as:  "invalid_login"
  get "unauthorized" => "home#unauthorized"


  resources :users do
    get "requests", on: :member


  end

  get "terms_of_use" => "sessions#terms_of_use", as: :terms_of_use
  get "accept_terms" => "sessions#accept_terms", as: :accept_terms

  root to: "home#index"

end
