Rails.application.routes.draw do
  get 'sequence/input'
  root 'sequence#input'
  post '/result', to: 'sequence#result'
  get 'show_xml', to: 'sequence#show_xml'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
