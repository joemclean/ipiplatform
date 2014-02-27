IpiPlatform::Application.routes.draw do

  resources :steps, except: :new do
    collection do
      get :reorder
      post :sort
    end
  end

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
  get 'resources/new', to: 'resources#new', as: :new_free_resource
  get 'resources/:id/edit/:step_id', to: 'resources#edit', as: :edit_resource
  get 'resources/:id/edit', to: 'resources#edit', as: :edit_free_resource
  post 'resources/:step_id', to: 'resources#create', as: :create_resource
  post 'resources/', to: 'resources#create', as: :create_free_resource
  patch 'resources/:id/:step_id', to: 'resources#update', as: :update_resource
  patch 'resources/:id', to: 'resources#update', as: :update_free_resource
  get 'steps/new/:value_proposition_id', to: 'steps#new', as: :new_step

  resources :value_proposition_categories
  resources :value_propositions
  resources :bookmarks

  resources :resources, except: [:new, :create, :edit, :update] do
    collection do
      get :existing
      get :reorder
      post :sort
    end

    member do
      post :add_to_step
    end

    resources :upvotes
    post 'comments/save'
    get 'comments/delete'
  end

  root 'pages#landing'
end
