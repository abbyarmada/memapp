require 'devise'
RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include ControllerHelpers, type: :controller
  config.include ValidUserRequestHelper, type: :request
  config.include Warden::Test::Helpers
end