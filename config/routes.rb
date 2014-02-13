IpiPlatform::Application.routes.draw do

  resources :steps, except: :new

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
  post 'resources/filter', to: 'resources#filter', as: :filter
  get 'resources/new/:step_id', to: 'resources#new', as: :new_resource

  get 'steps/new/:value_proposition_id', to: 'steps#new', as: :new_step

  resources :value_proposition_categories
  resources :value_propositions
  resources :bookmarks

  resources :resources, :except => :new do
    resources :upvotes
    post 'comments/save'
    get 'comments/delete'
  end

  root 'pages#landing'
end
