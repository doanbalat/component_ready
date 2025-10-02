require_relative "lib/component_ready/version"

Gem::Specification.new do |spec|
  spec.name        = "component_ready"
  spec.version     = ComponentReady::VERSION
  spec.authors     = ["ComponentReady Team"]
  spec.email       = ["team@componentready.com"]
  spec.homepage    = "https://github.com/doanbalat/component_ready"
  spec.summary     = "Modern, pre-styled web components for Rails applications"
  spec.description = "ComponentReady provides a collection of modern, pre-styled web components built with Tailwind CSS for Rails applications. Components include buttons, sliders, footers, pricing tables, login forms, and banners."
  spec.license     = "MIT"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/doanbalat/component_ready"
  spec.metadata["changelog_uri"] = "https://github.com/componentready/component_ready/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Runtime dependencies
  spec.add_dependency "rails", ">= 6.1"
  spec.add_dependency "actionview", ">= 6.1"

  # Development dependencies
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-rails", "~> 6.0"
  spec.add_development_dependency "rubocop", "~> 1.0"
  spec.add_development_dependency "rubocop-rails", "~> 2.0"
  spec.add_development_dependency "rubocop-rspec", "~> 2.0"
  spec.add_development_dependency "yard", "~> 0.9"

  # Specify minimum Ruby version
  spec.required_ruby_version = ">= 3.0.0"
end