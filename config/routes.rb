Appointime::Application.routes.draw do
  root :to => 'welcome#show'

  resource :session
end
