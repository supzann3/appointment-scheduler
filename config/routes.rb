Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :appointments, controller: 'appointment'
  get 'appointments/user/:user_id', to: 'appointment#show_user_appointments'
end
