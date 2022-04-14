Rails.application.routes.draw do
  devise_for :users


root 'welcome#index'

  namespace :admin do
    resources :jobs do
      member do
        post :publish
        post :hide
      end

      resources :resumes
    end
  end

  resources :jobs do
     resources :resumes


     put :favorite, on: :member
     member do
      post :add
      post :remove
    end

    collection do
         get :search
    end

   end

  resources :jobs
  resources :favorites
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
