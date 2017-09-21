Rails.application.routes.draw do

  resources :shelfs do
    resources :books
  end
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
