GoalSetter::Application.routes.draw do

  resources :users do
    resources :goals, except: [:destroy]
  end
  resource :session, only: [:new, :create, :destroy]

  resources :goals, only: [:destroy]

end