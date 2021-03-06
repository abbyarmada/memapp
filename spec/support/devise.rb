require 'support/controller_macros'
require 'support/ValidUserRequestHelper'
RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.extend ControllerMacros, type: :controller
  config.include ValidUserRequestHelper, type: :request
  config.include DeviseHelper, type: :request
  config.include Warden::Test::Helpers
end
