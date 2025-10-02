require 'spec_helper'

RSpec.describe ComponentReady::Components::Slider do
  let(:sample_images) do
    [
      { url: "/image1.jpg", alt: "Image 1" },
      { url: "/image2.jpg", alt: "Image 2" }
    ]
  end

  describe '#initialize' do
    it 'requires images parameter' do
      expect {
        described_class.new
      }.to raise_error(ComponentReady::InvalidOptions, /images.*required/)
    end

    it 'validates images array is not empty' do
      expect {
        described_class.new(images: [])
      }.to raise_error(ComponentReady::InvalidOptions, /at least 1 image/)
    end

    it 'validates image format' do
      invalid_images = [{ url: "/image.jpg" }] # missing alt
      
      expect {
        described_class.new(images: invalid_images)
      }.to raise_error(ComponentReady::InvalidOptions, /must have.*url.*alt/)
    end

    it 'accepts valid slider options' do
      slider = described_class.new(
        images: sample_images,
        autoplay: true,
        navigation: false,
        pagination: false,
        loop: false
      )

      expect(slider.images).to eq(sample_images)
      expect(slider.autoplay?).to be(true)
      expect(slider.navigation?).to be(false)
      expect(slider.pagination?).to be(false)
      expect(slider.loop?).to be(false)
    end
  end

  describe '#render' do
    it 'renders slider HTML with images' do
      slider = described_class.new(images: sample_images)
      html = slider.render

      expect(html).to include('class="slider')
      expect(html).to include("/image1.jpg")
      expect(html).to include("/image2.jpg")
      expect(html).to include("Image 1")
      expect(html).to include("Image 2")
    end

    it 'includes navigation when enabled' do
      slider = described_class.new(images: sample_images, navigation: true)
      html = slider.render

      expect(html).to include("prev")
      expect(html).to include("next")
    end

    it 'includes pagination when enabled' do
      slider = described_class.new(images: sample_images, pagination: true)
      html = slider.render

      expect(html).to include("pagination")
    end

    it 'includes autoplay data attribute when enabled' do
      slider = described_class.new(images: sample_images, autoplay: true)
      html = slider.render

      expect(html).to include('data-autoplay="true"')
    end
  end
end