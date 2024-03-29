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
    
    scope 'categories' do
      get '', to: 'categories#index'
      get ':id', to: 'categories#show'
      post 'create', to: 'categories#create'
      patch 'update/:id', to: 'categories#update'
      delete 'delete/:id', to: 'categories#delete'
    end

    scope 'feedbacks' do
      get '', to: 'feedbacks#index'
      get ':id', to: 'feedbacks#show'
      post 'create', to: 'feedbacks#create'
      patch 'update/:id', to: 'feedbacks#update'
      delete 'delete/:id', to: 'feedbacks#delete'
    end

  end
end
