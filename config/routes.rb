IpiPlatform::Application.routes.draw do
  
  get "personalities/create"
  get "personalities/update"

  resources :industries
  resources :sessions
  resources :users

  get "questions/new"
  get "surveys/new"
  get "surveys/take_survey", :as => :take_survey
  get "surveys/get_results", :as => :get_results
  get "surveys/view_results", :as => :view_results
  get "pages/home"
  get "pages/publisher"
  get "pages/innovator"
  get "pages/aboutus"
  get "pages/phases"
  get "pages/tools"
  get "pages/landing"

  get 'upvotes/clear_upvote', :as => :clear_upvote
  get 'bookmarks/make_bookmark', :as => :make_bookmark
  get 'bookmarks/unmake_bookmark', :as => :unmake_bookmark

  get 'tags/:tag', to: 'resources#index', as: :tag


  resources :traits
  resources :bookmarks
  
  resources :resources do
    resources :upvotes
    post 'comments/save'
    get 'comments/delete'
  end
  
  resources :suggestions
  resources :question_responses
  
  root 'pages#landing'
end
