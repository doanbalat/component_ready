source "https://rubygems.org"

# Specify your gem's dependencies in component_ready.gemspec
gemspec

gem "rake", "~> 13.0"

group :development, :test do
  gem "rspec", "~> 3.0"
  gem "rspec-rails", "~> 6.0"
  gem "rubocop", "~> 1.21"
  gem "rubocop-rails", "~> 2.0"
  gem "rubocop-rspec", "~> 2.0"
  gem "yard", "~> 0.9"
  gem "pry", "~> 0.14"
  gem "pry-byebug", "~> 3.9"
end

group :test do
  gem "capybara", "~> 3.36"
  gem "selenium-webdriver", "~> 4.0"
  gem "webdrivers", "~> 5.0"
  gem "rails", "~> 7.0"
  gem "sprockets-rails", ">= 2.0.0"
  gem "sqlite3", "~> 1.4"
end