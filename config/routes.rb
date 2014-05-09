Rails.application.routes.draw do
  get 'welcome/index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  resources :surveys, only: [] do
    resources :questionary_sessions
  end

  mount Helena::Engine => '/helena'
end
