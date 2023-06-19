Rails.application.routes.draw do
  get '/api/articles/:slug', to: 'articles#show'
  post '/api/articles', to: 'articles#create'
  put '/api/articles/:slug', to: 'articles#update'
  delete '/api/articles/:slug', to: 'articles#destroy'
end
