module ComponentReady
  module Components
    class Slider < ComponentReady::Base
      attr_reader :images, :autoplay, :navigation, :pagination, :loop

      def initialize(**options)
        @images = options.fetch(:images) { raise ComponentReady::InvalidOptions, "images parameter is required" }
        @autoplay = options.fetch(:autoplay, false)
        @navigation = options.fetch(:navigation, true)
        @pagination = options.fetch(:pagination, true)
        @loop = options.fetch(:loop, true)

        validate_images!
        
        super(**options)
      end

      def render
        <<~HTML.html_safe
          <div class="#{css_classes} #{slider_classes}" 
               #{slider_data_attributes}>
            <div class="slider-container overflow-hidden rounded-lg">
              <div class="slider-track flex transition-transform duration-300 ease-in-out">
                #{render_slides}
              </div>
            </div>
            #{render_navigation if @navigation}
            #{render_pagination if @pagination}
          </div>
        HTML
      end

      def autoplay?
        @autoplay
      end

      def navigation?
        @navigation
      end

      def pagination?
        @pagination
      end

      def loop?
        @loop
      end

      private

      def validate_images!
        if @images.empty?
          raise ComponentReady::InvalidOptions, "images must contain at least 1 image"
        end

        @images.each_with_index do |image, index|
          unless image.is_a?(Hash) && image[:url] && image[:alt]
            raise ComponentReady::InvalidOptions, 
                  "Image at index #{index} must have :url and :alt attributes"
          end
        end
      end

      def slider_classes
        "slider relative w-full max-w-4xl mx-auto"
      end

      def slider_data_attributes
        attributes = []
        attributes << 'data-autoplay="true"' if @autoplay
        attributes << 'data-loop="true"' if @loop
        attributes << "data-slides-count=\"#{@images.length}\""
        attributes.join(" ")
      end

      def render_slides
        @images.map.with_index do |image, index|
          <<~HTML
            <div class="slide w-full flex-none">
              <img src="#{image[:url]}" 
                   alt="#{image[:alt]}" 
                   class="w-full h-64 md:h-96 object-cover"
                   loading="#{index == 0 ? 'eager' : 'lazy'}">
            </div>
          HTML
        end.join
      end

      def render_navigation
        <<~HTML
          <div class="slider-navigation absolute inset-y-0 left-0 right-0 flex items-center justify-between px-4">
            <button class="nav-prev bg-white/80 hover:bg-white rounded-full p-2 shadow-lg transition-all duration-200 transform hover:scale-110" 
                    aria-label="Previous slide">
              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
              </svg>
            </button>
            <button class="nav-next bg-white/80 hover:bg-white rounded-full p-2 shadow-lg transition-all duration-200 transform hover:scale-110" 
                    aria-label="Next slide">
              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
              </svg>
            </button>
          </div>
        HTML
      end

      def render_pagination
        dots = @images.map.with_index do |_, index|
          <<~HTML
            <button class="pagination-dot w-3 h-3 rounded-full bg-white/50 hover:bg-white/80 transition-colors duration-200 #{index == 0 ? 'bg-white' : ''}" 
                    data-slide="#{index}" 
                    aria-label="Go to slide #{index + 1}"></button>
          HTML
        end

        <<~HTML
          <div class="pagination flex justify-center space-x-2 mt-4">
            #{dots.join}
          </div>
        HTML
      end

      # Override base classes for slider-specific styling
      def base_classes
        ""  # Slider doesn't use button-like base classes
      end

      def theme_classes
        ""  # Slider uses its own styling approach
      end

      def size_classes
        ""  # Slider manages its own sizing
      end

      def variant_classes
        ""  # Slider doesn't use variants like buttons
      end
    end
  end
end