Rails.application.routes.draw do
  resources :products, defaults: { format: :json }
  resources :orders, defaults: { format: :json }
end
