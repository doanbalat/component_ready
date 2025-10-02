require "component_ready/version"
require "component_ready/engine" if defined?(Rails::Engine)

module ComponentReady
  # Error classes
  class Error < StandardError; end
  class UnknownComponent < Error; end
  class InvalidOptions < Error; end

  # Configuration
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class Configuration
    attr_accessor :default_theme, :css_framework, :custom_themes, :accessibility

    def initialize
      @default_theme = :primary
      @css_framework = :tailwind
      @custom_themes = {}
      @accessibility = true
    end
  end
end

# Require core files after module definition
require "component_ready/base"
require "component_ready/helpers/component_helper"
require "component_ready/components"

# Component classes
require "component_ready/components/button"
require "component_ready/components/slider"
require "component_ready/components/footer"
require "component_ready/components/pricing"
require "component_ready/components/login"
require "component_ready/components/banner"