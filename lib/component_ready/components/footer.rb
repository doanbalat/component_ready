module ComponentReady
  module Components
    class Footer < ComponentReady::Base
      def initialize(**options)
        # TODO: Implement footer component
        super(**options)
      end

      def render
        "<div class='footer'>Footer component - Coming soon</div>".html_safe
      end
    end
  end
end