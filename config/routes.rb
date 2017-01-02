Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      get 'search' => 'searches#search'
      get 'recent' => 'searches#recent'
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

end
