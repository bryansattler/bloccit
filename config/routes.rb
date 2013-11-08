Bloccit::Application.routes.draw do

  # call the resources method, and pass it the :posts symbol
  # this instructs Rails to create routes for every CRUD action
  resources :posts

  match "about" => 'welcome#about', via: :get

  root to: 'welcome#index'

end