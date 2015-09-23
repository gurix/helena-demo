Rails.application.routes.draw do
  # We need to define devise_for just omniauth_callbacks otherwise it does not work with scoped locales
  # see https://github.com/plataformatec/devise/issues/2813
  devise_for :users, skip: [:session, :password, :registration, :confirmation], controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  scope '(:locale)' do
    get 'welcome/index'

    devise_for :users, skip: :omniauth_callbacks, controllers: { passwords: 'passwords', registrations: 'registrations' }

    root 'welcome#index'

    # We define here a route inside the locale thats just saves the current locale in the session and redirects to the normal omniauth callbacks
    get 'omniauth/:provider' => 'omniauth#localized', as: :localized_omniauth

    mount Helena::Engine => '/helena'
    mount HelenaAdministration::Engine, at: '/admin'
  end
end
