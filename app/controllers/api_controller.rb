class ApiController < ApplicationController
  respond_to :json
  before_filter :restrict_access

  private
  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      User.exists?(auth_token: token)
    end
  end

end
