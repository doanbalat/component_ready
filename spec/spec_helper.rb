require "bundler/setup"
require "component_ready"
require "rspec/rails"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!

  # Use color output
  config.color = true

  # Use documentation format for output
  config.default_formatter = "doc"
end