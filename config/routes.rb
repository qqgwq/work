Rails.application.routes.draw do
  resources :links
  get 'short_url' => 'links#show'
end
