

Rails.application.routes.draw do
  devise_for :users
  resources :restaurants do 
  	resources :reviews, expect: [:index, :show]
  	collection do
  		get 'search'
      get 'map'
      get 'localmap'
      get 'sentiment'
      get 'orders'
  	end
    resources :menus, expect: [:index]
    resources :orders, expect: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'restaurants#index'
  match '/about_us', to: 'pages#about_us', via: :get
  match '/contact_us',to:'pages#contact_us',via: :get
  match '/restaurants/:id/sentiment',to:'restaurants#sentiment', as: 'senti', via: :get
end
