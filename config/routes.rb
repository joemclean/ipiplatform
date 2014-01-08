IpiPlatform::Application.routes.draw do
  
  get 'personalities/create'
  get 'personalities/update'

  resources :sessions
  resources :users

  get 'pages/home'
  get 'pages/publisher'
  get 'pages/value_propositions'
  get 'pages/aboutus'
  get 'pages/landing'

  get 'upvotes/clear_upvote', :as => :clear_upvote
  get 'bookmarks/make_bookmark', :as => :make_bookmark
  get 'bookmarks/unmake_bookmark', :as => :unmake_bookmark

  get 'tags/:tag', to: 'resources#index', as: :tag


  resources :value_propositions
  resources :colors
  resources :bookmarks
  
  resources :resources do
    resources :upvotes
    post 'comments/save'
    get 'comments/delete'
  end
  
  resources :suggestions

  root 'pages#landing'
end
