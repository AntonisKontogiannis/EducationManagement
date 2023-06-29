Rails.application.routes.draw do
  resources :subjects
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
  resources :semesters
  resources :users, except: [:new]
  resources :contents
  resources :subject_attends
  get 'control_panel', to: 'pages#control_panel'
  get 'admin_settings', to: 'pages#admin_settings'
  get 'signup', to: 'users#new' 
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  patch 'global_settings_update', to: 'global_settings#update'
  post 'language_update_path', to: 'sessions#language_update'
end
