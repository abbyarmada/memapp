RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include ControllerMacros, type: :controller
  config.include ValidUserRequestHelper, type: :request
  config.include DeviseHelper, type: :request
  config.include Warden::Test::Helpers
end
