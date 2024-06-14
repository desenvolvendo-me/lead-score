require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LeadScore
  class Application < Rails::Application
    config.generators do |g|
      g.template_engine :railsui
      g.fallbacks[:railsui] = :erb

    end

    config.to_prepare do
      Devise::Mailer.layout "mailer"
    end

    # Config default time to Brasília for lesson launch_time
    config.time_zone = 'Brasilia'

    config.active_job.queue_adapter = :sidekiq

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Specify location below
    config.i18n.default_locale = 'pt-BR'
    config.i18n.locale = 'pt-BR'


    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/app/gateways)

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
