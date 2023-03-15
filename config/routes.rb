Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :authentication do
        post '/register', to: 'register#index'
        post '/login', to: 'login#index'
        get '/logout', to: 'logout#index'
      end

      namespace :users do
        get '/', to: 'list#index'
        post '/', to: 'create#index'
        get '/:id', to: 'detail#index'
        post '/:id', to: 'update#index'
        delete '/:id', to: 'delete#index'
      end
    end
  end

  match '*path', to: 'application#not_found', via: [:get, :post, :put, :patch, :delete]
end
