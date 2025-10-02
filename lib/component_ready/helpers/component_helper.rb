module ComponentReady
  module Helpers
    module ComponentHelper
      # Main helper method to render components
      def component_ready(component_type, **options)
        component_class = resolve_component_class(component_type)
        component_instance = component_class.new(**options)
        component_instance.render.html_safe
      rescue ComponentReady::Error => e
        handle_component_error(e, component_type, options)
      end

      private

      def resolve_component_class(component_type)
        class_name = "ComponentReady::Components::#{component_type.to_s.camelize}"
        
        begin
          class_name.constantize
        rescue NameError
          raise ComponentReady::UnknownComponent, 
                "No component registered for :#{component_type}. Available components: #{available_components.join(', ')}"
        end
      end

      def available_components
        ComponentReady::Components.constants
          .select { |c| ComponentReady::Components.const_get(c).is_a?(Class) }
          .map { |c| c.to_s.underscore.to_sym }
      end

      def handle_component_error(error, component_type, options)
        if Rails.env.production?
          Rails.logger.error "ComponentReady Error: #{error.message}"
          Rails.logger.error "Component: #{component_type}, Options: #{options.inspect}"
          ""
        else
          raise error
        end
      end
    end
  end
end