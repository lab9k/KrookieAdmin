Rails.application.routes.draw do
  get 'welcome/index'
  resources :books do
    post :send
  end
  root 'welcome#index'
end
