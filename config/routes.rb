Rails.application.routes.draw do
  devise_for :users
  resources :noticia
  resources :comentarios
  post 'noticias/comentar' , to: 'noticia#comentar'
  get 'noticias/admin', to: 'noticia#admin'
  get 'noticias/inicio', to: 'noticia#index'
  root 'noticia#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
