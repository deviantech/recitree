Rails.application.routes.draw do
  get '/recipes', controller: 'recipes', action: 'index'
end
