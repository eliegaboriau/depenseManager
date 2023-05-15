Rails.application.routes.draw do
  resources :depenses
  resources :categories
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'depenses#new', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end

