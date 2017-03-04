Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :users do #api/v1/users(get,post), api/v1/users/:id(put,patch,delete)
        collection do
          get 'users-by-name', to: "users#users_by_name" # api/v1/users/users-by-name(get)
        end
        resources :products, only: [:index,:destroy,:update,:create] do # api/v1/users/:user_id/products(get,post), api/v1/users/:user_id/products/:id(put,patch,delete)
          member do
            match 'add-favorite', to: "products#add_favorite", via: [:post,:patch,:put] # api/v1/users/:user_id/products/:id/add-favorite(post,put,patch)
            delete 'remove-favorite', to: "products#remove_favorite" # api/v1/users/:id/products/:id/remove-favorite(delete)
          end
        end
        resources :events, only: [:index] # api/v1/users/:user_id/events
        resources :posts, only: [:index,:destroy,:update,:create] #api/v1/users/:user_id/posts(get,post), api/v1/users/:user_id/posts/:id(put,patch,delete)
        resources :comments, only: [:index] # api/v1/users/:user_id/comments(get)
      end
      resources :products, only: [:index,:show] do # api/v1/products(get), api/v1/products/:id(get)
        resources :categories, only: [:index,:update,:create,:destroy] # api/v1/products/:product_id/categories(get,post), api/v1/products/:product_id/categories/:id(put,patch,delete)
      end
      resources :categories, only: [:index,:show] # api/v1/categories(get), api/v1/categories/:id(get)
      resources :events do # api/v1/events(get,post), api/v1/events/:id(put,patch,delete)
        collection do
          get 'events-by-name', to: "events#events_by_name" # api/v1/events/events-by-name(get)
        end
        resources :users, only: [] do
          match '', to: "events#go_event", via: [:post,:patch,:put] # api/v1/events/event_id/users/:id(put,patch,post)
          delete '', to: "events#not_go_event" # api/v1/events/event_id/users/:id(delete)
        end
      end
      resources :posts, only: [:show,:index] do # api/v1/posts(get), api/v1/posts/:id(get)
        resources :images, only: [:index,:create,:update,:destroy] # api/v1/posts/:post_id/images(get,post), api/v1/posts/:post_id/images/:id(put,patch,delete)
        resources :comments, only: [:index] # api/v1/posts/:post_id/comments
      end
      resources :images, only: [:show,:index] # api/v1/images(get), api/v1/images/:id(get)
      resources :comments do # api/v1/comments(get,post), api/v1/comments/:id(put,patch,get,delete)
        collection do
          get 'replies', to: "comments#replies" #api/v1/comments/:id/replies(get)
        end
        resources :images, only: [:index,:create,:update,:destroy] #api/v1/comments/:comment_id/images(get,post), api/v1/comments/:comment_id/images/:id(put,patch,delete)
      end
      root to: "products#index" #api/v1
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
