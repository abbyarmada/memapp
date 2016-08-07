group :red_green_refactor, halt_on_fail: true do
  guard :rspec, cmd: 'NO_COVERAGE=true spring rspec --tag ~@slow', failed_mode: :keep, all_after_pass: true do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb')  { 'spec' }
    watch('spec/rails_helper.rb') { 'spec' }
    # Rails example
    watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^app/(.*)(\.erb|\.haml|\.slim)$})          { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
    watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
    watch(%r{^spec/support/(.+)\.rb$})                  { 'spec' }
    watch('config/routes.rb')                           { 'spec/routing' }
    watch('app/controllers/application_controller.rb')  { 'spec/controllers' }
    # Capybara features specs
    watch(%r{^app/views/(.+)/.*\.(erb|haml|slim)$})     { |m| "spec/features/#{m[1]}_spec.rb" }
    # Turnip features and steps
    watch(%r{^spec/acceptance/(.+)\.feature$})
    watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/acceptance' }
  end
  guard 'cucumber' do
    watch(%r{^features/.+\.feature$})
    watch(%r{^features/support/.+$}) { 'features' }
    watch(%r{^features/step_definitions/(.+)_steps\.rb$}) do |m|
      Dir[File.join("**/#{m[1]}.feature")][0] || 'features'
    end
  end
  guard :rubocop, all_on_start: false, cli: ['--format', 'clang', '--rails', 'app', 'bin', 'config', 'lib', 'script', 'spec'] do
    watch(%r{^app/.*\.rb$})
    watch(%r{^config/.*\.rb$})
    watch(%r{^lib/.*\.rb$})
    watch(%r{^spec/.*\.rb$})
    watch(%r{^script/.*\.rb$})
  end
end
