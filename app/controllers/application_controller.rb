# frozen_string_literal: true

class ApplicationController < ActionController::API
  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end
end
