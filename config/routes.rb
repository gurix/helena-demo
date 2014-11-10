Rails.application.routes.draw do
  # We need to define devise_for just omniauth_callbacks otherwise it does not work with scoped locales
  # see https://github.com/plataformatec/devise/issues/2813
  devise_for :users, skip: [:session, :password, :registration, :confirmation], controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  scope '(:locale)' do

    get 'welcome/index'

    devise_for :users, skip: :omniauth_callbacks, controllers: { passwords: 'passwords', registrations: 'registrations' }

    # You can have the root of your site routed with "root"
    root 'welcome#index'

    mount Helena::Engine => '/helena'
    mount HelenaAdministration::Engine, at: '/admin'
  end
end
