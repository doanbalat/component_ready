require 'spec_helper'

RSpec.describe ComponentReady::Helpers::ComponentHelper do
  include ComponentReady::Helpers::ComponentHelper

  describe '#component_ready' do
    it 'renders button component' do
      html = component_ready(:button, text: "Test Button")
      
      expect(html).to include("Test Button")
      expect(html).to include("button")
    end

    it 'raises error for unknown component' do
      expect {
        component_ready(:unknown_component, text: "Test")
      }.to raise_error(ComponentReady::UnknownComponent, /No component registered/)
    end

    it 'passes options to component' do
      html = component_ready(:button, text: "Custom", theme: :secondary)
      
      expect(html).to include("bg-gray-600") # secondary theme
    end

    context 'in production environment' do
      before do
        allow(Rails).to receive(:env).and_return(double(production?: true))
        allow(Rails).to receive(:logger).and_return(double(error: nil))
      end

      it 'returns empty string for errors' do
        result = component_ready(:unknown_component, text: "Test")
        expect(result).to eq("")
      end

      it 'logs errors' do
        logger = double
        allow(Rails).to receive(:logger).and_return(logger)
        
        expect(logger).to receive(:error).twice
        component_ready(:unknown_component, text: "Test")
      end
    end
  end

  describe '#available_components' do
    it 'returns list of available components' do
      # This will depend on what components we have defined
      components = send(:available_components)
      expect(components).to be_an(Array)
    end
  end
end