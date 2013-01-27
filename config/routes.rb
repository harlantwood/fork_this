ForkThis::Engine.routes.draw do
  root :to => 'forked_pages#new'
  resources :forked_pages, :only => %w[ new create ]
end
