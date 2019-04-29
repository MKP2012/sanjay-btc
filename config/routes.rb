Rails.application.routes.draw do
  devise_for :users, :path_prefix => 'd'
  resources :users, :only =>[:show]
  root "users#show"

  get 'user/withdraw_money', to: 'users#withdraw_money'
  patch 'user/withdraw_money', to: 'users#after_withdraw_money'
  get 'user/transfer_to_another_user', to: 'users#transfer_to_another_user'
  patch 'user/after_transfer_to_another_user', to: 'users#after_transfer_to_another_user'

  get 'transaction_reports', to: 'users#transaction_reports'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
