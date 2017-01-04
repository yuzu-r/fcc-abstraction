Rails.application.routes.draw do
  namespace :api  , defaults: {format: 'json'} do
    namespace :v1 do
      get 'search' => 'searches#search'
      get 'recent' => 'searches#recent'
    end
  end
  root 'static_pages#welcome'

end
