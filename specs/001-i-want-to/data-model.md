# Data Model: ComponentReady Ruby Gem

## Core Entities

### Component
**Purpose**: Base abstraction for all UI components with consistent interface
**Attributes**:
- `type` (Symbol): Component type identifier (:button, :slider, :footer, etc.)
- `theme` (Symbol): Color theme (:primary, :secondary, :success, :warning, :danger)
- `size` (Symbol): Size variant (:sm, :md, :lg, :xl) 
- `variant` (Symbol): Style variant (:default, :outline, :ghost, :link)
- `custom_classes` (String): Additional Tailwind classes for customization
- `options` (Hash): Component-specific parameters

**Validation Rules**:
- `type` must be in registered component list
- `theme` must be in [:primary, :secondary, :success, :warning, :danger, :neutral]
- `size` must be in [:xs, :sm, :md, :lg, :xl] when applicable
- `custom_classes` must be valid CSS class string format

### ButtonComponent < Component
**Attributes**:
- `text` (String, required): Button label text
- `disabled` (Boolean): Disabled state
- `loading` (Boolean): Loading state with spinner
- `icon` (String): Icon class or identifier
- `href` (String): URL for link-style buttons
- `form_action` (Symbol): Rails form helper action (:submit, :button, :reset)

**Validation Rules**:
- `text` must be present and non-empty
- `href` and `form_action` are mutually exclusive
- `icon` must be valid icon identifier when provided

### SliderComponent < Component  
**Attributes**:
- `images` (Array): Array of image objects with url/alt text
- `autoplay` (Boolean): Automatic slide progression
- `navigation` (Boolean): Show navigation arrows
- `pagination` (Boolean): Show pagination dots
- `loop` (Boolean): Loop back to first slide

**Validation Rules**:
- `images` must contain at least 1 item
- Each image must have valid `url` and `alt` attributes

### FooterComponent < Component
**Attributes**:
- `links` (Hash): Grouped footer links by section
- `social_links` (Array): Social media links with platform/url
- `copyright` (String): Copyright text
- `logo` (Hash): Logo configuration with text/image

**Validation Rules**:
- `links` sections must be non-empty Hash
- `social_links` must have valid platform identifiers
- `copyright` text required

### PricingComponent < Component
**Attributes**:
- `plans` (Array): Pricing plan configurations
- `currency` (String): Currency symbol/code
- `billing_period` (Symbol): :monthly, :yearly, :once
- `featured_plan` (String): ID of highlighted plan

**Validation Rules**:
- `plans` must contain at least 1 plan
- Each plan must have `name`, `price`, `features` attributes
- `featured_plan` must match existing plan ID when provided

### LoginComponent < Component
**Attributes**:
- `fields` (Array): Form field configurations
- `social_login` (Array): Social authentication providers
- `forgot_password` (Boolean): Show forgot password link
- `signup_link` (Boolean): Show signup link

**Validation Rules**:
- `fields` must include email/username field
- `fields` must include password field
- Social providers must be from supported list

### BannerComponent < Component
**Attributes**:
- `message` (String, required): Banner message text
- `type` (Symbol): Banner type (:info, :success, :warning, :error)
- `dismissible` (Boolean): Can be closed by user
- `action_text` (String): Call-to-action button text
- `action_url` (String): CTA button URL

**Validation Rules**:
- `message` must be present and non-empty
- `type` must be valid banner type
- `action_text` and `action_url` must both be present or both absent

## Component Relationships

### Inheritance Hierarchy
```
ComponentReady::Base
├── ButtonComponent
├── SliderComponent  
├── FooterComponent
├── PricingComponent
├── LoginComponent
└── BannerComponent
```

### Template Relationships
- Each component maps to template directory: `/templates/{component_name}/`
- Variants stored in: `/templates/{component_name}/variants/{variant_name}.html.erb`
- Shared partials in: `/templates/shared/`

## Configuration Schema

### Theme Configuration
```ruby
{
  primary: {
    bg: "bg-blue-600",
    text: "text-white", 
    border: "border-blue-600",
    hover: "hover:bg-blue-700"
  },
  secondary: {
    bg: "bg-gray-600",
    text: "text-white",
    border: "border-gray-600", 
    hover: "hover:bg-gray-700"
  }
  # ... additional themes
}
```

### Size Configuration
```ruby
{
  xs: { padding: "px-2 py-1", text: "text-xs" },
  sm: { padding: "px-3 py-2", text: "text-sm" },
  md: { padding: "px-4 py-2", text: "text-base" },
  lg: { padding: "px-6 py-3", text: "text-lg" },
  xl: { padding: "px-8 py-4", text: "text-xl" }
}
```

## State Transitions

### Component Lifecycle
1. **Initialize** - Validate parameters, set defaults
2. **Configure** - Apply theme/size/variant settings  
3. **Render** - Generate HTML with computed CSS classes
4. **Cache** - Memoize result for repeated renders

### Interactive States (JavaScript-enabled components)
- **Loading** - Show spinner, disable interactions
- **Error** - Display error styling and messages  
- **Success** - Show success feedback
- **Disabled** - Non-interactive state

## Validation Framework

### Parameter Validation
```ruby
validates :theme, inclusion: { in: VALID_THEMES }
validates :size, inclusion: { in: VALID_SIZES }
validates_presence_of :required_fields
validates_format_of :css_classes, with: /\A[\w\s-]*\z/
```

### Cross-component Validation  
- Ensure theme consistency across related components
- Validate accessibility requirements (WCAG compliance)
- Check Tailwind class compatibility