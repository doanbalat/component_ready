module ComponentReady
  class Base
    attr_reader :options, :theme, :size, :variant, :custom_classes

    VALID_THEMES = [:primary, :secondary, :success, :warning, :danger, :neutral].freeze
    VALID_SIZES = [:xs, :sm, :md, :lg, :xl].freeze
    VALID_VARIANTS = [:default, :outline, :ghost, :link].freeze

    def initialize(**options)
      @options = options
      @theme = options.fetch(:theme, ComponentReady.configuration.default_theme)
      @size = options.fetch(:size, :md)
      @variant = options.fetch(:variant, :default)
      @custom_classes = options.fetch(:custom_classes, "")
      
      validate_options!
    end

    def render
      raise NotImplementedError, "Subclasses must implement #render method"
    end

    protected

    def validate_options!
      validate_theme!
      validate_size! if respond_to?(:size_classes, true)
      validate_variant! if respond_to?(:variant_classes, true)
      validate_custom_classes!
    end

    def validate_theme!
      unless VALID_THEMES.include?(@theme)
        raise ComponentReady::InvalidOptions, 
              "Invalid theme: #{@theme}. Valid options: #{VALID_THEMES}"
      end
    end

    def validate_size!
      unless VALID_SIZES.include?(@size)
        raise ComponentReady::InvalidOptions,
              "Invalid size: #{@size}. Valid options: #{VALID_SIZES}"
      end
    end

    def validate_variant!
      unless VALID_VARIANTS.include?(@variant)
        raise ComponentReady::InvalidOptions,
              "Invalid variant: #{@variant}. Valid options: #{VALID_VARIANTS}"
      end
    end

    def validate_custom_classes!
      return if @custom_classes.empty?
      
      unless @custom_classes.is_a?(String) && @custom_classes.match?(/\A[\w\s\-:]*\z/)
        raise ComponentReady::InvalidOptions,
              "Invalid custom_classes format. Must be a string with valid CSS class names"
      end
    end

    # Theme-based CSS classes
    def theme_classes
      @theme_classes ||= case @theme
      when :primary
        "bg-blue-600 text-white border-blue-600 hover:bg-blue-700"
      when :secondary
        "bg-gray-600 text-white border-gray-600 hover:bg-gray-700"
      when :success
        "bg-green-600 text-white border-green-600 hover:bg-green-700"
      when :warning
        "bg-yellow-500 text-black border-yellow-500 hover:bg-yellow-600"
      when :danger
        "bg-red-600 text-white border-red-600 hover:bg-red-700"
      when :neutral
        "bg-gray-200 text-gray-900 border-gray-200 hover:bg-gray-300"
      else
        "bg-blue-600 text-white border-blue-600 hover:bg-blue-700"
      end
    end

    # Size-based CSS classes (override in subclasses)
    def size_classes
      case @size
      when :xs then "px-2 py-1 text-xs"
      when :sm then "px-3 py-2 text-sm"
      when :md then "px-4 py-2 text-base"
      when :lg then "px-6 py-3 text-lg"
      when :xl then "px-8 py-4 text-xl"
      else "px-4 py-2 text-base"
      end
    end

    # Combine all CSS classes
    def css_classes(*additional_classes)
      classes = [
        base_classes,
        theme_classes,
        size_classes,
        variant_classes,
        @custom_classes,
        *additional_classes
      ].compact.reject(&:empty?).join(" ")
      
      # Remove duplicate classes and return
      classes.split.uniq.join(" ")
    end

    # Base classes for the component (override in subclasses)
    def base_classes
      "inline-flex items-center justify-center rounded-md border font-medium focus:outline-none focus:ring-2 focus:ring-offset-2"
    end

    # Variant classes (override in subclasses)  
    def variant_classes
      case @variant
      when :outline
        "bg-transparent border-2"
      when :ghost
        "bg-transparent border-transparent hover:bg-gray-100"
      when :link
        "bg-transparent border-transparent underline-offset-4 hover:underline"
      else
        ""
      end
    end

    # Template rendering helper
    def render_template(template_name, locals = {})
      template_path = File.join(
        ComponentReady::Engine.root, 
        "lib", 
        "component_ready", 
        "templates", 
        component_name.downcase,
        "#{template_name}.html.erb"
      )
      
      if File.exist?(template_path)
        template_content = File.read(template_path)
        ERB.new(template_content).result(binding)
      else
        raise ComponentReady::Error, "Template not found: #{template_path}"
      end
    end

    # Extract component name from class name
    def component_name
      self.class.name.split("::").last.gsub(/Component$/, "").downcase
    end
  end
end