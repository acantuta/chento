Chento::Application.routes.draw do
  resources :areas

  root "pages#home"
  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"
  
  
  devise_for :users

  namespace :admin do
    root "base#index"
    resources :users
    resources :doctipos
    resources :areas do
      collection do
        get 'asignacion'        
      end

      member do
        post 'asignar_user'
        delete 'destroy_asignacion'
      end
    end
  end

end
