# frozen_string_literal: true

Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get 'home/index'
      resources :links
    end
  end

  root to: 'links#index'
  get '/:slug', to: 'links#show', as: :short

  # constraints subdomain: 'api' do
  #   scope module: 'api' do
  #     namespace :v1 do
  #       get 'home/index'
  #       resources :links
  #     end
  #   end
  # end
end
