module ComponentReady
  module Components
    class Banner < ComponentReady::Base
      attr_reader :message, :type, :dismissible, :action_text, :action_url

      VALID_TYPES = [:info, :success, :warning, :error].freeze

      def initialize(**options)
        @message = options.fetch(:message) { raise ComponentReady::InvalidOptions, "message parameter is required" }
        @type = options.fetch(:type, :info)
        @dismissible = options.fetch(:dismissible, true)
        @action_text = options.fetch(:action_text, nil)
        @action_url = options.fetch(:action_url, nil)

        validate_type!
        validate_action_options!
        
        # Override theme based on banner type
        options[:theme] = derive_theme_from_type(@type)
        
        super(**options)
      end

      def render
        <<~HTML.html_safe
          <div class="#{css_classes} #{banner_classes}" role="alert">
            <div class="flex">
              <div class="flex-shrink-0">
                #{render_icon}
              </div>
              <div class="ml-3 flex-1">
                <p class="text-sm font-medium">
                  #{@message}
                </p>
                #{render_action if @action_text && @action_url}
              </div>
              #{render_dismiss_button if @dismissible}
            </div>
          </div>
        HTML
      end

      def dismissible?
        @dismissible
      end

      private

      def validate_type!
        unless VALID_TYPES.include?(@type)
          raise ComponentReady::InvalidOptions,
                "Invalid type: #{@type}. Valid options: #{VALID_TYPES}"
        end
      end

      def validate_action_options!
        if (@action_text && !@action_url) || (!@action_text && @action_url)
          raise ComponentReady::InvalidOptions,
                "action_text and action_url must both be present or both absent"
        end
      end

      def derive_theme_from_type(type)
        case type
        when :info then :primary
        when :success then :success
        when :warning then :warning
        when :error then :danger
        else :primary
        end
      end

      def banner_classes
        "rounded-md p-4 border-l-4"
      end

      def render_icon
        icon_class = "h-5 w-5"
        
        case @type
        when :info
          <<~HTML
            <svg class="#{icon_class} text-blue-400" fill="currentColor" viewBox="0 0 20 20">
              <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/>
            </svg>
          HTML
        when :success
          <<~HTML
            <svg class="#{icon_class} text-green-400" fill="currentColor" viewBox="0 0 20 20">
              <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
            </svg>
          HTML
        when :warning
          <<~HTML
            <svg class="#{icon_class} text-yellow-400" fill="currentColor" viewBox="0 0 20 20">
              <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
            </svg>
          HTML
        when :error
          <<~HTML
            <svg class="#{icon_class} text-red-400" fill="currentColor" viewBox="0 0 20 20">
              <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
            </svg>
          HTML
        end
      end

      def render_action
        <<~HTML
          <div class="mt-2">
            <a href="#{@action_url}" 
               class="text-sm font-medium underline hover:no-underline">
              #{@action_text}
            </a>
          </div>
        HTML
      end

      def render_dismiss_button
        <<~HTML
          <div class="ml-auto pl-3">
            <div class="-mx-1.5 -my-1.5">
              <button type="button" 
                      class="inline-flex rounded-md p-1.5 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-offset-2"
                      data-dismiss="banner"
                      aria-label="Dismiss">
                <svg class="h-5 w-5" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"/>
                </svg>
              </button>
            </div>
          </div>
        HTML
      end

      # Override theme classes for banner-specific styling
      def theme_classes
        case @type
        when :info
          "bg-blue-50 border-blue-400 text-blue-800"
        when :success
          "bg-green-50 border-green-400 text-green-800"
        when :warning
          "bg-yellow-50 border-yellow-400 text-yellow-800"
        when :error
          "bg-red-50 border-red-400 text-red-800"
        else
          "bg-blue-50 border-blue-400 text-blue-800"
        end
      end

      # Override base classes for banner-specific styling  
      def base_classes
        ""
      end

      def size_classes
        ""
      end

      def variant_classes
        ""
      end
    end
  end
end