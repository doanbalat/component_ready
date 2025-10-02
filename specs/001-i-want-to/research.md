# Research: ComponentReady Ruby Gem

## Ruby Gem Architecture Research

### Decision: Rails Engine Pattern
**Rationale**: Rails Engine provides the cleanest integration for view helpers and templates while maintaining gem isolation. Allows automatic helper inclusion and template path registration.

**Alternatives considered**:
- Plain Ruby gem with manual helper inclusion - requires more manual setup
- Mountable engine - unnecessary complexity for component library
- Direct view partial distribution - less maintainable, no programmatic interface

### Component Generation Strategy

### Decision: Ruby Classes + ERB Templates
**Rationale**: Ruby classes provide programmatic interface with parameter validation, while ERB templates ensure Rails integration and maintainability.

**Alternatives considered**:
- Pure string concatenation - less maintainable, no Rails asset integration  
- Haml templates - additional dependency, less universally adopted
- ViewComponent pattern - too heavy for simple component library

### Tailwind CSS Integration

### Decision: Class-based Components with Customization
**Rationale**: Components output raw Tailwind classes allowing full customization while providing sensible defaults. No CSS compilation required from gem.

**Alternatives considered**:
- Custom CSS with Tailwind extension - requires build process
- SCSS with Tailwind imports - additional dependency complexity
- Inline styles - loses Tailwind's utility and customizability

### Testing Strategy

### Decision: RSpec + Rails System Tests  
**Rationale**: RSpec for unit testing component logic, Rails system tests for integration validation with real Tailwind rendering.

**Alternatives considered**:
- Minitest only - less expressive for component behavior testing
- Capybara integration tests - overkill for template output validation
- Pure unit tests - insufficient for Rails integration validation

### Component Theming Architecture

### Decision: Parameter-based Theme Selection + Class Override
**Rationale**: Balances simplicity (theme: :primary) with flexibility (custom_classes: "bg-purple-500") for different developer skill levels.

**Alternatives considered**:
- CSS variables - requires additional CSS, conflicts with Tailwind philosophy
- Configuration files - too complex for component styling
- Only class overrides - too complex for basic usage

### Performance Optimization

### Decision: Class Memoization + Template Caching
**Rationale**: Memoize generated class strings, leverage Rails template caching for repeated renders with same parameters.

**Alternatives considered**:
- No optimization - acceptable for most use cases but leaves performance on table
- Pre-compiled templates - complexity doesn't justify marginal gains
- External caching - unnecessary external dependency

## Implementation Patterns

### Component Base Class Pattern
```ruby
class ComponentReady::Base
  def initialize(**options)
    @options = options
    validate_options!
  end
  
  def render
    # Template rendering logic
  end
  
  private
  
  def css_classes
    # Memoized class generation
  end
end
```

### Rails Integration Pattern  
```ruby
module ComponentReady::Helpers
  def component_ready(component_type, **options)
    component_class = "ComponentReady::Components::#{component_type.to_s.camelize}".constantize
    component_class.new(**options).render
  end
end
```

### Template Organization Pattern
```
templates/
├── button/
│   ├── _default.html.erb
│   ├── _primary.html.erb  
│   └── _secondary.html.erb
└── [component]/
    └── variants/
```

## Dependencies Analysis

### Required Dependencies
- Ruby >= 3.0 (modern Rails compatibility)
- Rails >= 6.1 (engine functionality)
- No additional runtime dependencies

### Peer Dependencies  
- Tailwind CSS (documented requirement)
- Rails application with configured asset pipeline

### Development Dependencies
- RSpec Rails
- Capybara (for system tests)
- Standard (Ruby linting)
- Yard (documentation)

## Risk Assessment

### Low Risk
- Tailwind CSS compatibility (well-established patterns)
- Rails integration (standard engine approach)
- Component rendering performance (template caching)

### Medium Risk  
- Tailwind version compatibility across different Rails apps
- Component customization depth vs simplicity balance

### Mitigation Strategies
- Document Tailwind version compatibility matrix
- Provide both simple (theme-based) and advanced (class override) APIs
- Comprehensive integration testing with different Rails/Tailwind versions