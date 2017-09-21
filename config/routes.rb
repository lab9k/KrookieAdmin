Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  resources :shelfs do
    resources :books
  end
end
