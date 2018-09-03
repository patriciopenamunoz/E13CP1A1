Rails.application.routes.draw do
  get 'sales/new'
  get 'sales/done'
  post 'sales', to: 'sales#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
