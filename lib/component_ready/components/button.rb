module ComponentReady
  module Components
    class Button < ComponentReady::Base
      attr_reader :text, :disabled, :loading, :icon, :href, :form_action

      def initialize(**options)
        @text = options.fetch(:text) { raise ComponentReady::InvalidOptions, "text parameter is required" }
        @disabled = options.fetch(:disabled, false)
        @loading = options.fetch(:loading, false)
        @icon = options.fetch(:icon, nil)
        @href = options.fetch(:href, nil)
        @form_action = options.fetch(:form_action, nil)

        validate_mutually_exclusive_options!
        
        super(**options)
      end

      def render
        if @href
          render_link
        else
          render_button
        end
      end

      def disabled?
        @disabled || @loading
      end

      def loading?
        @loading
      end

      private

      def validate_mutually_exclusive_options!
        if @href && @form_action
          raise ComponentReady::InvalidOptions, 
                "href and form_action are mutually exclusive"
        end
      end

      def render_link
        disabled_attr = disabled? ? 'aria-disabled="true"' : ''
        
        "<a href=\"#{@href}\" class=\"#{css_classes} #{disabled_classes}\" #{disabled_attr}>" \
        "#{button_content}</a>"
      end

      def render_button
        disabled_attr = disabled? ? 'disabled' : ''
        busy_attr = @loading ? 'aria-busy="true"' : ''
        
        "<button type=\"#{button_type}\" class=\"#{css_classes} #{disabled_classes}\" #{disabled_attr} #{busy_attr}>" \
        "#{button_content}</button>"
      end

      def button_content
        if @loading
          '<svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-current" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">' \
          '<circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>' \
          '<path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>' \
          '</svg>Loading...'
        elsif @icon
          "<span class=\"mr-2\">#{@icon}</span>#{@text}"
        else
          @text
        end
      end

      def button_type
        case @form_action
        when :submit then "submit"
        when :reset then "reset"
        else "button"
        end
      end

      def disabled_classes
        disabled? ? "opacity-50 cursor-not-allowed" : ""
      end

      # Override base classes for button-specific styling
      def base_classes
        "inline-flex items-center justify-center rounded-md border font-medium " \
        "focus:outline-none focus:ring-2 focus:ring-offset-2 transition-colors duration-200"
      end

      # Button-specific variant classes
      def variant_classes
        case @variant
        when :outline
          "bg-transparent border-2 hover:bg-gray-50"
        when :ghost
          "bg-transparent border-transparent hover:bg-gray-100"
        when :link
          "bg-transparent border-transparent underline-offset-4 hover:underline p-0"
        else
          ""
        end
      end
    end
  end
end