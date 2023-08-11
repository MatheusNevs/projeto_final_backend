Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  scope 'api' do
    scope 'users' do
      post 'login', to: 'users#login'
      get '', to: 'users#index'
      get 'show', to: 'users#show'
      post 'create', to: 'users#create'
      patch 'update', to: 'users#update'
      patch 'add_picture', to: 'users#add_picture'
      delete 'delete', to: 'users#delete'
    end

    scope 'posts' do
      get '', to: 'posts#index'
      get ':id', to: 'posts#show'
      post 'create', to: 'posts#create'
      patch 'update/:id', to: 'posts#update'
      delete 'delete/:id', to: 'posts#delete'
    end

  end
end
