# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Links', type: :request do
  # before(:each) do
  #   host! 'lvh.me'
  # end

  describe 'GET /' do
    it 'should returns http redirect' do
      get '/'
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'GET /show' do
    let(:link) { FactoryBot.create(:link) }

    it 'should returns http not_found for an invalid slug' do
      get '/invalid_slug'
      expect(response).to have_http_status(:not_found)
    end

    it 'should returns http redirect for an valid slug' do
      get "/#{link.slug}"
      expect(response).to have_http_status(:redirect)
    end
  end
end
