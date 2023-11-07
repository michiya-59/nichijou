# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Nichijou
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.railties_order = [ActiveStorage::Engine, :main_app, :all]
    config.load_defaults 7.1
    config.time_zone = "Tokyo"
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join("config/locales/**/*.yml").to_s]
    config.autoload_lib(ignore: %w(assets tasks))
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: false,
                       view_specs: false,
                       routing_specs: false,
                       controller: false
    end
  end
end
