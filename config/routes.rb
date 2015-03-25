Chento::Application.routes.draw do
  namespace :areas do
    resources :base
    root "base#index"
  end

  resources :documentos

  root "pages#home"
  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"
  
  
  devise_for :users

  namespace :admin do
    root "base#index"
    resources :users
    resources :doctipos
    resources :docestados
    resources :movacciones
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
