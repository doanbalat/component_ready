# ComponentReady

Modern, pre-styled web components for Rails applications built with Tailwind CSS.

ComponentReady provides a collection of beautiful, responsive UI components that work seamlessly with Rails and Tailwind CSS. Perfect for solo developers who want professional-looking interfaces without the hassle of custom CSS design.

## Features

- 🎨 **Modern Design**: Beautiful components inspired by modern design systems
- 🎯 **Rails Integration**: Seamless integration with Rails view helpers
- 🎨 **Tailwind CSS**: Built exclusively with Tailwind CSS classes
- 📱 **Responsive**: Mobile-first responsive design
- ♿ **Accessible**: WCAG compliant components
- 🎨 **Themeable**: Multiple color themes and customization options
- ⚡ **Performance**: Minimal overhead, <1ms rendering time

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'component_ready'
```

And then execute:

    $ bundle install

**Prerequisites**: Ensure Tailwind CSS is configured in your Rails application.

## Usage

### Basic Usage

```erb
<!-- Button Component -->
<%= component_ready(:button, text: "Click me", theme: :primary) %>

<!-- Banner Component -->
<%= component_ready(:banner, message: "Welcome to our site!", type: :info) %>

<!-- Image Slider -->
<%= component_ready(:slider, images: [
  { url: "/image1.jpg", alt: "Image 1" },
  { url: "/image2.jpg", alt: "Image 2" }
]) %>
```

### Advanced Usage

```erb
<!-- Button with custom styling -->
<%= component_ready(:button, 
      text: "Custom Button", 
      theme: :secondary, 
      size: :lg,
      variant: :outline,
      custom_classes: "shadow-lg hover:shadow-xl") %>

<!-- Dismissible banner with action -->
<%= component_ready(:banner,
      message: "New feature available!",
      type: :success,
      action_text: "Learn more",
      action_url: "/features",
      dismissible: true) %>
```

## Available Components

### Button
- **Themes**: primary, secondary, success, warning, danger, neutral
- **Sizes**: xs, sm, md, lg, xl
- **Variants**: default, outline, ghost, link
- **Features**: loading states, icons, disabled state, form integration

### Banner
- **Types**: info, success, warning, error
- **Features**: dismissible, call-to-action buttons, icons

### Slider
- **Features**: autoplay, navigation arrows, pagination dots, responsive images
- **Options**: loop control, custom styling

*More components coming soon: Footer, Pricing, Login forms*

## Theming

ComponentReady supports multiple built-in themes:

```erb
<%= component_ready(:button, text: "Primary", theme: :primary) %>
<%= component_ready(:button, text: "Success", theme: :success) %>
<%= component_ready(:button, text: "Warning", theme: :warning) %>
```

### Custom Styling

Override styles with custom Tailwind classes:

```erb
<%= component_ready(:button, 
      text: "Custom", 
      custom_classes: "bg-gradient-to-r from-purple-500 to-pink-500") %>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/doanbalat/component_ready/.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).