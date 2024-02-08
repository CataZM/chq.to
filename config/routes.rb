Rails.application.routes.draw do
    devise_for :users, controllers: { registrations: 'users/registrations' }
    
    get "up" => "rails/health#show", as: :rails_health_check

    resources :links do
        member do
            get 'stats', to: 'links#stats'
            delete 'custom_delete', to: 'links#custom_delete', as: 'custom_delete'
            post 'check_password', to: 'links#check_password_link'
        end
    end
    get 'links/:id/redirect', to: 'links#redirect_to_link', as: 'redirect_link'

    root 'main#home'
end
