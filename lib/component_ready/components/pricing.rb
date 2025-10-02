module ComponentReady
  module Components
    class Pricing < ComponentReady::Base
      def initialize(**options)
        # TODO: Implement pricing component
        super(**options)
      end

      def render
        "<div class='pricing'>Pricing component - Coming soon</div>".html_safe
      end
    end
  end
end