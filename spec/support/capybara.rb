Capybara.asset_host = 'http://localhost:3000'
require 'capybara/poltergeist'
options = { js_errors: false, debug: false }

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, options)
end

Capybara.javascript_driver = :poltergeist
