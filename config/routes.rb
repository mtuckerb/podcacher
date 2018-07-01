Rails.application.routes.draw do
  resources :episodes
  resources :podcasts
  post 'update_podcast/:id' ,to: "podcasts#update_podcast", as: :update_podcast
  root "podcasts#index"
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
