require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SolidusStore
  class Application < Rails::Application
    # Load application's model / class decorators
    initializer 'spree.decorators' do |app|
      config.to_prepare do
        Dir.glob(Rails.root.join('app/**/*_decorator*.rb')) do |path|
          require_dependency(path)
        end
      end
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end

module AmazingStore
  class Application < Rails::Application
    # ...

    # Don't initialize FactoryBot if it's not in the current Bundler group.
    if defined?(FactoryBotRails)
      initializer after: 'factory_bot.set_factory_paths' do
        require 'spree/testing_support/factory_bot'

        # The paths for Solidus factories.
        solidus_paths = Spree::TestingSupport::FactoryBot.definition_file_paths

        # Optional: Any factories you want to require from extensions.
        extension_paths = [
          # MySolidusExtension::Engine.root.join("lib/solidus_content/factories/order.rb"),
          # MySolidusExtension::Engine.root.join("lib/solidus_content/factories/product.rb"),
        ]

        # Your application's own factories.
        app_paths = [
          # Rails.root.join('lib/factories'),
          Rails.root.join('spec/factories'),
        ]

        FactoryBot.definition_file_paths = solidus_paths + extension_paths + app_paths
      end
    end
  end
end