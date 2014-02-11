Shitta::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  # config.action_mailer.raise_delivery_errors = false
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { host: ENV["SHITTA_MAIL_HOST"], port: 3000 }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: ENV['SHITTA_SMTP_URL'],
    port: ENV['SHITTA_SMTP_PORT'],
    domain: ENV['SHITTA_SMTP_DOMAIN'],
    user_name: ENV['SHITTA_SMTP_USER'],
    password: ENV['SHITTA_SMTP_PASSWORD'],
    authentication: 'plain',
    enable_starttls_auto: true
  }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
  config.assets.logger = false

  config.eager_load = false
end
