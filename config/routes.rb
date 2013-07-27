Easyblog::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :posts do
    member do
      post :mark_archived
    end
    resources :comments
  end
  
  post 'posts/:post_id/comments/:comment_id/like', to: "comments#like"
  post 'posts/:post_id/comments/:comment_id/dislike', to: "comments#dislike"
  post 'posts/:post_id/comments/:comment_id/uninsult', to: "comments#uninsult"
end
