Rails.application.routes.draw do
  get "/:short_url", to: "urls#show"
  get "shortened/:short_url", to: "urls#shortened", as: :shortened
  resources :urls, only: [:create, :new]
end
