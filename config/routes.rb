Rails.application.routes.draw do
  resources :components

  resources :master_slide_templates do 
    post 'component/:component_id/add', to: 'master_slide_templates#add_component', as: 'add_component'
  end
  post 'master_slide_template_component/:master_slide_template_component_id/update', to: 'master_slide_templates#update_component', as: 'update_component'


  devise_for :users, controllers: { invitations: 'users/invitations', registrations: 'users/registrations'}
  

  resources :organisations do
    post "user/:user_id/remove", to: 'users/organisations#remove', as: :remove_user
    post "user/:user_id/add", to: 'users/organisations#add', as: :add_user
    resources :slide_templates
    resources :meetings do
      resources :slides
      resources :agendas do
        post 'move/:direction', to: 'agendas#move', as: :move
        post 'complete', to: 'agendas#complete', as: :complete
      end
      resources :meeting_actions do
        post 'move/:direction', to: 'meeting_actions#move', as: :move
        post 'complete', to: 'agendas#complete', as: :complete
      end
    end
  end

  root "organisations#index"

end
