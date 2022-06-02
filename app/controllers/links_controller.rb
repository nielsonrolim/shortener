# frozen_string_literal: true

class LinksController < ApplicationController
  def index
    redirect_to 'https://lavanderia60minutos.com.br/lojas/'
  end

  def show
    link = Link.find_by(slug: params[:slug])
    if link.nil?
      render 'errors/404', status: 404 
      return
    end

    link.update_attribute(:click_count, link.click_count + 1)
    redirect_to link.url
  end
end
