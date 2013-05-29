Appointime::Application.routes.draw do
  root :to => 'welcome#show'

  resources :users
    get 'signup', to: 'users#new', as: 'signup'

  resource :session
    get 'login', to: 'sessions#new', as: 'login'
    get 'logout', to: 'sessions#destroy', as: 'logout'

  namespace :admin do
    resource :dashboard, :only => :show
  end
end
