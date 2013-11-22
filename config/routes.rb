Grapey::Application.routes.draw do

  devise_for :users

  mount Grapey::API => '/api'

  root :to => "home#index"
end
