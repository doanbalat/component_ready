require 'rails/engine'

module ComponentReady
  class Engine < ::Rails::Engine
    isolate_namespace ComponentReady

    # Add lib directories to load path
    config.autoload_paths += %W[
      #{root}/lib
      #{root}/lib/component_ready
      #{root}/lib/component_ready/components
      #{root}/lib/component_ready/helpers
    ]

    # Configure view paths for templates
    config.paths["app/views"] = []
    config.paths["app/views"] << "lib/component_ready/templates"

    # Initialize ComponentReady helpers in ActionView
    initializer "component_ready.action_view" do |app|
      ActiveSupport.on_load :action_view do
        include ComponentReady::Helpers::ComponentHelper
      end
    end

    # Configure generators
    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
  end
end