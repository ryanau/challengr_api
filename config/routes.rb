Rails.application.routes.draw do
  scope '/api' do
    scope '/v1' do
      devise_for :users
    end
  end

  namespace 'api' do
    namespace 'v1' do
      post 'auth/facebook', to: 'auth#facebook'
      get 'sessions/identity', to: 'sessions#identity'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'application#index'
end
