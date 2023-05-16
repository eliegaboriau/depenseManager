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
  get 'account/edit', to: 'account#edit', as: 'edit_account'
  patch 'account', to: 'account#update'
  get 'account', to: 'account#edit' # Optional: Redirect the main account page to the edit action
end

