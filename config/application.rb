require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Gaia
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.gaia_settings = config_for(:app_settings)

    config.action_mailer.delivery_job = "ActionMailer::MailDeliveryJob"

    # set delivery method to :smtp, :sendmail or :test
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = { address: ENV['SMTP_HOST'], port: ENV['SMTP_PORT'] }
    config.action_mailer.default_url_options = { host: ENV['HOST'] }

    config.active_support.cache_format_version = 7.0
    config.active_support.disable_to_s_conversion = true

    config.active_record.legacy_connection_handling = false
  end
end
