# ComponentReady Gem API Contract

## Component Helper Interface

### component_ready(component_type, **options) -> String (HTML)
**Purpose**: Main helper method to render components in Rails views
**Parameters**:
- `component_type` (Symbol): Component identifier
- `**options` (Hash): Component-specific configuration

**Returns**: HTML string with Tailwind CSS classes

**Example Usage**:
```erb
<%= component_ready(:button, text: "Click me", theme: :primary, size: :md) %>
<%= component_ready(:slider, images: @gallery_images, autoplay: true) %>
<%= component_ready(:pricing, plans: @pricing_plans, featured: "pro") %>
```

**Error Handling**:
- Raises `ComponentReady::UnknownComponent` for invalid component types
- Raises `ComponentReady::InvalidOptions` for validation failures
- Returns empty string for graceful degradation when `Rails.env.production?`

## Component Class Interface

### ButtonComponent
```ruby
ComponentReady::Button.new(
  text: String,              # required
  theme: Symbol,             # default: :primary
  size: Symbol,              # default: :md  
  variant: Symbol,           # default: :default
  disabled: Boolean,         # default: false
  loading: Boolean,          # default: false
  icon: String,              # optional
  href: String,              # optional (creates link)
  custom_classes: String     # optional
).render -> String
```

**Valid Enums**:
- `theme`: [:primary, :secondary, :success, :warning, :danger, :neutral]
- `size`: [:xs, :sm, :md, :lg, :xl]
- `variant`: [:default, :outline, :ghost, :link]

### SliderComponent  
```ruby
ComponentReady::Slider.new(
  images: Array,             # required [{ url:, alt: }]
  theme: Symbol,             # default: :primary
  autoplay: Boolean,         # default: false
  navigation: Boolean,       # default: true
  pagination: Boolean,       # default: true
  loop: Boolean,             # default: true
  custom_classes: String     # optional
).render -> String
```

### FooterComponent
```ruby
ComponentReady::Footer.new(
  links: Hash,               # required { "Section" => [{ text:, url: }] }
  social_links: Array,       # optional [{ platform:, url: }]
  copyright: String,         # required
  logo: Hash,                # optional { text: or image_url: }
  theme: Symbol,             # default: :neutral
  custom_classes: String     # optional
).render -> String
```

### PricingComponent
```ruby
ComponentReady::Pricing.new(
  plans: Array,              # required [{ name:, price:, features:, cta_text: }]
  currency: String,          # default: "$"
  billing_period: Symbol,    # default: :monthly
  featured_plan: String,     # optional plan name to highlight
  theme: Symbol,             # default: :primary
  custom_classes: String     # optional
).render -> String
```

### LoginComponent
```ruby
ComponentReady::Login.new(
  fields: Array,             # default: [email, password]
  social_login: Array,       # optional [:google, :facebook, :github]
  forgot_password: Boolean,  # default: true
  signup_link: Boolean,      # default: true
  theme: Symbol,             # default: :primary
  custom_classes: String     # optional
).render -> String
```

### BannerComponent
```ruby
ComponentReady::Banner.new(
  message: String,           # required
  type: Symbol,              # default: :info
  dismissible: Boolean,      # default: true
  action_text: String,       # optional
  action_url: String,        # optional
  theme: Symbol,             # derived from type
  custom_classes: String     # optional
).render -> String
```

**Valid Enums**:
- `type`: [:info, :success, :warning, :error]

## Configuration Interface

### Global Configuration
```ruby
ComponentReady.configure do |config|
  config.default_theme = :primary
  config.css_framework = :tailwind  # future: support other frameworks
  config.custom_themes = { ... }
  config.accessibility = true
end
```

## Rails Integration Contract

### Engine Initialization
- Automatically includes `ComponentReady::Helpers` in `ActionView::Base`
- Registers template paths for component partials
- Loads component classes and configurations

### Template Resolution
- Component templates located in `lib/component_ready/templates/`
- Follows Rails naming conventions: `_component_name.html.erb`
- Variant templates in subdirectories: `variants/_outline.html.erb`

### Asset Integration  
- No CSS/JS assets bundled (pure Tailwind approach)
- JavaScript enhancements loaded via data attributes and Stimulus (optional)
- Images referenced via Rails asset helpers when needed

## Error Handling Contract

### Validation Errors
```ruby
# Invalid component type
ComponentReady::UnknownComponent: "No component registered for :unknown_type"

# Missing required parameters  
ComponentReady::InvalidOptions: "Missing required parameter: text"

# Invalid parameter values
ComponentReady::InvalidOptions: "Invalid theme: :invalid_theme. Valid options: [:primary, :secondary, ...]"
```

### Graceful Degradation
- Development: Raise detailed error messages
- Production: Log errors, return empty string or basic fallback HTML
- Test: Always raise errors for proper test coverage

## Backward Compatibility Contract

### Versioning Promise
- Major versions (1.0 -> 2.0): Breaking changes allowed
- Minor versions (1.0 -> 1.1): New components/options only
- Patch versions (1.0.0 -> 1.0.1): Bug fixes, no API changes

### Deprecation Policy  
- Features deprecated for one minor version before removal
- Clear migration guides provided for major version upgrades
- Legacy parameter names supported with deprecation warnings