Rails.application.routes.draw do
  root 'books#index'
  resources :books, only: %i[show index]
end
