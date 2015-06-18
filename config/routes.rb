Chento::Application.routes.draw do
  namespace :areas do
    resources :base do
      member do
        get 'documentos_esperando'
        get 'documentos_recibir'
        get 'documentos_recibidos'
        get 'documentos_enviados'
        get 'documentos_todos'
        post 'recibir_documento'
        post 'cambiar_estado_documento'
      end
    end
    root "base#index"
  end

  resources :documentos do
    member do
      post 'cambiar_estado'
      get 'cambiar_estado'
    end
  end

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
