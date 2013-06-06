require 'sidekiq/web'

Appointime::Application.routes.draw do
  root :to => 'welcome#show'

  resources :users
    get 'signup', to: 'users#new', as: 'signup'

  resource :session
    get 'login', to: 'sessions#new', as: 'login'
    get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'about_meghan', to: 'extras#about', as: 'about'
  get 'services', to: 'extras#services', as: 'services'
  get 'faq', to: 'extras#faq', as: 'faq'
  get 'location', to: 'extras#location', as: 'location'

  namespace :admin do
    resource :dashboard, :only => :show
    resources :appointments
      get 'clients', to: 'appointments#clients', as: 'clients'
  end

  resources :appointments

  mount Sidekiq::Web, at: '/sidekiq'
end
