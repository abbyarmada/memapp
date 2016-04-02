# .simplecov
SimpleCov.start do
  add_filter 'spec'
  add_filter 'config'
  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
  add_group 'Mailers', 'app/mailers'
end # if ENV["COVERAGE"]
