require 'sidekiq/web'

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  get '/health' => 'pages#health_check'
  get 'api-docs/v1/swagger.yaml' => 'swagger#yaml'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # New route from the new code
  post '/api/v1/todos', to: 'api/todos#create'

  # Existing routes from the existing code
  namespace :api do
    post '/error_logs', to: 'error_logs#create'
  end

  # ... other routes ...
end
