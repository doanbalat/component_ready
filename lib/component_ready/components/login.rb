module ComponentReady
  module Components
    class Login < ComponentReady::Base
      def initialize(**options)
        # TODO: Implement login component
        super(**options)
      end

      def render
        "<div class='login'>Login component - Coming soon</div>".html_safe
      end
    end
  end
end