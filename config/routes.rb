Rails.application.routes.draw do
  resources :recipes
  resources :ingredients
  root to: redirect('/recipes')
end
