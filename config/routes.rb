Rails.application.routes.draw do


  root 'welcomes#index'

  resources :profiles do
    resources :educations, only: [:create, :update, :destroy]
    resources :experiences, only: [:create, :update, :destroy]
    resources :assets, only: [:create, :update, :destroy]
    resources :skills, only: [:create, :update, :destroy]
    resources :projects, only: [:create, :update, :destroy]
    resources :inquiries
  end

  resources :users, only: [:new, :create, :index, :update] do
    collection do
      get   :edit
      patch :update
    end
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :password_resets

  post "/contact_us" => "contact_us#create"

end
