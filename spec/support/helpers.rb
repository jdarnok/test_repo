require 'support/helpers/session_helpers'
require 'support/helpers/request_helpers'
RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
  config.include Requests::JsonHelpers, type: :request
  config.include Requests::AuthHelpers, type: :request
end
