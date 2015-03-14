module Requests
  module JsonHelpers
    def json
      @json ||= JSON.parse(response.body)
    end
  end

  module AuthHelpers
    def set_auth_token user
      { 'HTTP_AUTHORIZATION'=>"Token token=\"#{user.auth_token}\"" }
    end
  end
end