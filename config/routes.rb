require 'sidekiq/web'
Rails.application.routes.draw do
  resources :posts
	get 'admin/integrations', to: 'page#integrations'
	get 'admin/team', to: 'page#team'
	get 'admin/billing', to: 'page#billing'
	get 'admin/notifications', to: 'page#notifications'
	get 'admin/settings', to: 'page#settings'
	get 'admin/activity', to: 'page#activity'
	get 'admin/profile', to: 'page#profile'
	get 'admin/people', to: 'page#people'
	get 'admin/calendar', to: 'page#calendar'
	get 'admin/assignments', to: 'page#assignments'
	get 'admin/message', to: 'page#message'
	get 'admin/messages', to: 'page#messages'
	get 'admin/project', to: 'page#project'
	get 'admin/projects', to: 'page#projects'
	get 'admin/dashboard', to: 'page#dashboard'
  get 'homepage', to: 'page#homepage'
  get 'about', to: 'page#about'
	get 'pricing', to: 'page#pricing'
  get 'faq', to: 'page#faq'
  get 'billing', to: 'page#billing'
  get 'integrations', to: 'page#integrations'
  get 'team', to: 'page#team'
  get 'settings', to: 'page#settings'
  get 'activity', to: 'page#activity'
  get 'notifications', to: 'page#notifications'
  if Rails.env.development? || Rails.env.test?
    mount Railsui::Engine, at: "/railsui"
  end

  # Inherits from Railsui::PageController#index
  # To overide, add your own page#index view or change to a new root
  # Visit the start page for Rails UI any time at /railsui/start
  root action: :index, controller: "railsui/page"

  devise_for :users
  mount Sidekiq::Web => '/sidekiq'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :admin_users,
             ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :goals do
      namespace :done do
        post :index
        post :show
        post :many
      end
    end
  end

  namespace :manager do
    resources :goals
    namespace :goals do
      namespace :done do
        get :index
        get :show
        post :many
      end
    end

    get '', to: 'home#index', as: :home
  end

  scope module: :external do
    get '', to: 'home#index', as: :home
    get 'stimulus', to: 'home#stimulus', as: :stimulus
  end


  post 'checkout', to: 'checkout#create', as: 'checkout'
  get 'checkout/success', to: 'checkout#success', as: 'checkout_success'
  get 'checkout/cancel', to: 'checkout#cancel', as: 'checkout_cancel'


  resources :clients do
    member do
      patch :update_stripe_info
    end
  end

end
