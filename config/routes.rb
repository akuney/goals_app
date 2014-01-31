GoalSetter::Application.routes.draw do

  resources :users do
    resources :goals, only: [:new, :index]
  end
  resource :session

  resources :goals, except: [:new, :index]

end