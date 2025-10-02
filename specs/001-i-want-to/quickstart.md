# ComponentReady Quickstart Guide

## Installation

Add to your Rails application's Gemfile:
```ruby
gem 'component_ready'
```

Run bundle install:
```bash
bundle install
```

## Prerequisites

Ensure Tailwind CSS is configured in your Rails application:

1. **Install Tailwind CSS** (if not already installed):
```bash
./bin/bundle add tailwindcss-rails
./bin/rails tailwindcss:install
```

2. **Verify Tailwind is working** - check that `app/assets/stylesheets/application.tailwind.css` exists and is loaded.

## Basic Usage

### 1. Simple Button
```erb
<!-- app/views/pages/home.html.erb -->
<%= component_ready(:button, text: "Get Started") %>
```

**Output**: A primary-themed, medium-sized button with Tailwind styling.

### 2. Customized Button
```erb
<%= component_ready(:button, 
    text: "Sign Up", 
    theme: :success, 
    size: :lg,
    icon: "user-plus" 
) %>
```

### 3. Image Slider
```erb
<%= component_ready(:slider, 
    images: [
      { url: "image1.jpg", alt: "Slide 1" },
      { url: "image2.jpg", alt: "Slide 2" },
      { url: "image3.jpg", alt: "Slide 3" }
    ],
    autoplay: true 
) %>
```

### 4. Pricing Table
```erb
<%
pricing_plans = [
  {
    name: "Basic",
    price: 9,
    features: ["Feature 1", "Feature 2", "Feature 3"],
    cta_text: "Choose Basic"
  },
  {
    name: "Pro", 
    price: 29,
    features: ["Everything in Basic", "Feature 4", "Feature 5"],
    cta_text: "Choose Pro"
  }
]
%>

<%= component_ready(:pricing, 
    plans: pricing_plans,
    featured_plan: "Pro"
) %>
```

### 5. Login Form
```erb
<%= component_ready(:login, 
    social_login: [:google, :github],
    forgot_password: true 
) %>
```

### 6. Footer
```erb
<%
footer_links = {
  "Product" => [
    { text: "Features", url: "/features" },
    { text: "Pricing", url: "/pricing" }
  ],
  "Company" => [
    { text: "About", url: "/about" },
    { text: "Contact", url: "/contact" }
  ]
}

social_links = [
  { platform: :twitter, url: "https://twitter.com/yourcompany" },
  { platform: :github, url: "https://github.com/yourcompany" }
]
%>

<%= component_ready(:footer,
    links: footer_links,
    social_links: social_links,
    copyright: "© 2025 Your Company. All rights reserved."
) %>
```

### 7. Notification Banner
```erb
<%= component_ready(:banner,
    message: "New features available! Check out our latest updates.",
    type: :success,
    action_text: "Learn More",
    action_url: "/updates"
) %>
```

## Customization

### Theme Selection
Available themes for all components:
- `:primary` (default blue)
- `:secondary` (gray) 
- `:success` (green)
- `:warning` (yellow)
- `:danger` (red)
- `:neutral` (gray)

```erb
<%= component_ready(:button, text: "Warning", theme: :warning) %>
```

### Size Options
Available sizes (where applicable):
- `:xs` (extra small)
- `:sm` (small)
- `:md` (medium, default)
- `:lg` (large)
- `:xl` (extra large)

```erb
<%= component_ready(:button, text: "Large Button", size: :lg) %>
```

### Custom Styling
Add additional Tailwind classes:
```erb
<%= component_ready(:button, 
    text: "Custom Button", 
    custom_classes: "shadow-lg hover:shadow-xl transform hover:-translate-y-1"
) %>
```

## Complete Example Page

```erb
<!-- app/views/landing/index.html.erb -->
<div class="min-h-screen bg-gray-50">
  <!-- Header Banner -->
  <%= component_ready(:banner,
      message: "🎉 Limited time: 50% off all plans!",
      type: :success,
      action_text: "Get Discount",
      action_url: "#pricing"
  ) %>

  <!-- Hero Section -->
  <div class="container mx-auto px-4 py-16 text-center">
    <h1 class="text-5xl font-bold mb-8">Build Beautiful Apps Fast</h1>
    <p class="text-xl text-gray-600 mb-8">Professional UI components for Rails developers</p>
    
    <div class="space-x-4">
      <%= component_ready(:button, 
          text: "Start Free Trial", 
          theme: :primary, 
          size: :lg
      ) %>
      <%= component_ready(:button, 
          text: "View Demo", 
          variant: :outline, 
          size: :lg
      ) %>
    </div>
  </div>

  <!-- Image Slider -->
  <%= component_ready(:slider, 
      images: @demo_images,
      autoplay: true,
      custom_classes: "max-w-4xl mx-auto"
  ) %>

  <!-- Pricing Section -->
  <div id="pricing" class="container mx-auto px-4 py-16">
    <h2 class="text-3xl font-bold text-center mb-12">Choose Your Plan</h2>
    <%= component_ready(:pricing, 
        plans: @pricing_plans,
        featured_plan: "Pro"
    ) %>
  </div>

  <!-- Footer -->
  <%= component_ready(:footer,
      links: @footer_links,
      social_links: @social_links,
      copyright: "© 2025 ComponentReady. All rights reserved."
  ) %>
</div>
```

## Testing Your Components

### System Test Example
```ruby
# spec/system/components_spec.rb
require 'rails_helper'

RSpec.describe 'ComponentReady Components', type: :system do
  it 'renders button component correctly' do
    visit root_path
    
    expect(page).to have_css('button', text: 'Get Started')
    expect(page).to have_css('.bg-blue-600') # Primary theme
  end

  it 'renders interactive slider' do
    visit root_path
    
    expect(page).to have_css('[data-component="slider"]')
    expect(page).to have_css('.slider-navigation')
  end
end
```

## Troubleshooting

### Component not rendering
1. Verify Tailwind CSS is installed and configured
2. Check Rails logs for component errors
3. Ensure required parameters are provided

### Styling issues  
1. Check Tailwind CSS is compiling correctly
2. Verify no CSS conflicts with existing styles
3. Use browser developer tools to inspect generated classes

### JavaScript not working
1. Ensure Stimulus is installed (for interactive components)
2. Check browser console for JavaScript errors
3. Verify data attributes are present on components

## Next Steps

- Browse the [Component Gallery](./component_gallery.md) for all available components
- Read the [Customization Guide](./customization.md) for advanced styling
- Check out [Integration Examples](./integration_examples.md) for real-world usage patterns