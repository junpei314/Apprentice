Rails.application.routes.draw do
  get 'todos/create'
  root "todo#index"
  get "/todos/new", to: 'todo#new'
  resources :todos, :except => :show
end
