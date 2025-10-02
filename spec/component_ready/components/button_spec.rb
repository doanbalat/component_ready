require 'spec_helper'

RSpec.describe ComponentReady::Components::Button do
  describe '#initialize' do
    it 'requires text parameter' do
      expect {
        described_class.new
      }.to raise_error(ComponentReady::InvalidOptions, /text.*required/)
    end

    it 'accepts valid button options' do
      button = described_class.new(
        text: "Click me",
        theme: :primary,
        size: :lg,
        disabled: true,
        loading: true,
        icon: "plus",
        href: "https://example.com"
      )

      expect(button.text).to eq("Click me")
      expect(button.theme).to eq(:primary)
      expect(button.size).to eq(:lg)
      expect(button.disabled?).to be(true)
      expect(button.loading?).to be(true)
      expect(button.icon).to eq("plus")
      expect(button.href).to eq("https://example.com")
    end

    it 'validates mutually exclusive href and form_action' do
      expect {
        described_class.new(
          text: "Submit",
          href: "https://example.com",
          form_action: :submit
        )
      }.to raise_error(ComponentReady::InvalidOptions, /href.*form_action.*mutually exclusive/)
    end
  end

  describe '#render' do
    it 'renders basic button HTML' do
      button = described_class.new(text: "Click me")
      html = button.render

      expect(html).to include("Click me")
      expect(html).to include("button")
      expect(html).to include("bg-blue-600") # primary theme
    end

    it 'renders link when href provided' do
      button = described_class.new(text: "Link", href: "https://example.com")
      html = button.render

      expect(html).to include("href=\"https://example.com\"")
      expect(html).to include("<a")
    end

    it 'includes disabled attribute when disabled' do
      button = described_class.new(text: "Disabled", disabled: true)
      html = button.render

      expect(html).to include("disabled")
      expect(html).to include("opacity-50") # disabled styling
    end

    it 'includes loading spinner when loading' do
      button = described_class.new(text: "Loading", loading: true)
      html = button.render

      expect(html).to include("Loading...")
      expect(html).to include("animate-spin") # spinner animation
    end

    it 'includes icon when provided' do
      button = described_class.new(text: "With Icon", icon: "plus")
      html = button.render

      expect(html).to include("plus")
    end

    it 'applies variant classes correctly' do
      outline_button = described_class.new(text: "Outline", variant: :outline)
      html = outline_button.render

      expect(html).to include("bg-transparent")
      expect(html).to include("border-2")
    end

    it 'applies custom classes' do
      button = described_class.new(text: "Custom", custom_classes: "my-custom-class")
      html = button.render

      expect(html).to include("my-custom-class")
    end
  end

  describe '#button_type' do
    it 'returns "button" for basic button' do
      button = described_class.new(text: "Basic")
      expect(button.send(:button_type)).to eq("button")
    end

    it 'returns "submit" for form actions' do
      button = described_class.new(text: "Submit", form_action: :submit)
      expect(button.send(:button_type)).to eq("submit")
    end
  end
end