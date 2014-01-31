GoalSetter::Application.routes.draw do

  resources :users do
    resources :goals, only: [:new, :index, :create]
  end
  resource :session, only: [:new, :create, :destroy]

  resources :goals, except: [:new, :index, :create]

end