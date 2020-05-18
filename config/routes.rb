Rails.application.routes.draw do
  resources :cars
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'templates#index'
  resources :templates
  get '/search' => 'templates#search', :as => 'search_page'
  # get '/search' => 'users#search', :as => 'search_page'
  resources :cars do
    match '/scrape', to: 'cars#scrape', via: :post, on: :collection
    collection do 
      post :import
    end

    match '/scrape2', to: 'cars#scrape2', via: :post, on: :collection
    collection do 
      post :import
    end

  # root to: 'cars#index'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
