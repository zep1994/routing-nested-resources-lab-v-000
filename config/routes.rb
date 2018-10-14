Rails.application.routes.draw do
  resources :artists do 
    resources :songs, only: [:show, :index]
  resources :songs
end
