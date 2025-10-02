require 'spec_helper'

RSpec.describe ComponentReady::Base do
  let(:base_component) { described_class.new }

  describe '#initialize' do
    it 'sets default options' do
      expect(base_component.theme).to eq(:primary)
      expect(base_component.size).to eq(:md)
      expect(base_component.variant).to eq(:default)
      expect(base_component.custom_classes).to eq("")
    end

    it 'accepts custom options' do
      component = described_class.new(
        theme: :secondary,
        size: :lg,
        variant: :outline,
        custom_classes: "my-class"
      )
      
      expect(component.theme).to eq(:secondary)
      expect(component.size).to eq(:lg)
      expect(component.variant).to eq(:outline)
      expect(component.custom_classes).to eq("my-class")
    end
  end

  describe 'validation' do
    it 'validates theme' do
      expect {
        described_class.new(theme: :invalid_theme)
      }.to raise_error(ComponentReady::InvalidOptions, /Invalid theme/)
    end

    it 'validates size' do
      expect {
        described_class.new(size: :invalid_size)
      }.to raise_error(ComponentReady::InvalidOptions, /Invalid size/)
    end

    it 'validates variant' do
      expect {
        described_class.new(variant: :invalid_variant)
      }.to raise_error(ComponentReady::InvalidOptions, /Invalid variant/)
    end

    it 'validates custom_classes format' do
      expect {
        described_class.new(custom_classes: "invalid@class!")
      }.to raise_error(ComponentReady::InvalidOptions, /Invalid custom_classes format/)
    end
  end

  describe '#theme_classes' do
    it 'returns correct classes for primary theme' do
      component = described_class.new(theme: :primary)
      expect(component.send(:theme_classes)).to include("bg-blue-600", "text-white")
    end

    it 'returns correct classes for secondary theme' do
      component = described_class.new(theme: :secondary)
      expect(component.send(:theme_classes)).to include("bg-gray-600", "text-white")
    end
  end

  describe '#size_classes' do
    it 'returns correct classes for different sizes' do
      xs_component = described_class.new(size: :xs)
      expect(xs_component.send(:size_classes)).to include("px-2", "py-1", "text-xs")
      
      lg_component = described_class.new(size: :lg)
      expect(lg_component.send(:size_classes)).to include("px-6", "py-3", "text-lg")
    end
  end

  describe '#css_classes' do
    it 'combines all CSS classes correctly' do
      component = described_class.new(
        theme: :primary,
        size: :md,
        custom_classes: "extra-class"
      )
      
      classes = component.send(:css_classes)
      expect(classes).to include("bg-blue-600")
      expect(classes).to include("px-4")
      expect(classes).to include("extra-class")
    end

    it 'removes duplicate classes' do
      component = described_class.new(custom_classes: "px-4 py-2")
      classes = component.send(:css_classes)
      expect(classes.scan("px-4").length).to eq(1)
    end
  end

  describe '#render' do
    it 'raises NotImplementedError' do
      expect {
        base_component.render
      }.to raise_error(NotImplementedError, /Subclasses must implement #render method/)
    end
  end
end