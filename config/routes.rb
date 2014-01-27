IpiPlatform::Application.routes.draw do

  resources :sessions
  resources :users

  get 'pages/home'
  get 'pages/publisher'
  get 'pages/value_proposition_categories'
  get 'pages/aboutus'
  get 'pages/landing'

  get 'upvotes/clear_upvote', :as => :clear_upvote
  get 'bookmarks/make_bookmark', :as => :make_bookmark
  get 'bookmarks/unmake_bookmark', :as => :unmake_bookmark

  get 'tags/:tag', to: 'resources#index', as: :tag


  resources :value_proposition_categories
  resources :value_propositions
  resources :bookmarks
  
  resources :resources do
    resources :upvotes
    post 'comments/save'
    get 'comments/delete'
  end
  
  resources :suggestions

  root 'pages#landing'
end
