Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get '/', to:'welcome#index'

  #Shelters
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete 'shelters/:id', to: 'shelters#destroy'

  #Pets
  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  #Shelter_Pets
  get '/shelters/:id/pets', to: 'shelter_pets#index'
  get '/shelters/:id/pets/new', to: 'shelter_pets#new'
  post '/shelters/:id/pets', to: 'shelter_pets#create'
  delete '/shelters/:id/pets/:petid', to: 'shelter_pets#destroy'

  #Users
  get '/users/new', to: 'users#new'
  get '/users/:id', to: 'users#show'
  post '/users/:id', to: 'users#create'

  #Shelter_Reviews
  get '/shelters/:id/reviews/new', to: 'shelter_reviews#new'
  post '/shelters/:id/reviews', to: 'shelter_reviews#create'
  get '/shelters/:id/reviews/:review_id/edit', to: 'shelter_reviews#edit'
  patch '/shelters/:id/reviews/:review_id', to: 'shelter_reviews#update'
  delete '/shelters/:id/reviews/:review_id', to: 'shelter_reviews#destroy'

  #Applications
  get 'applications/new', to: "applications#new"
  get '/applications/:id', to: "applications#show"
  post '/applications/:id', to: "applications#create"
end
