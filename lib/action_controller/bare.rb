require 'action_controller'
require 'action_controller/log_subscriber'

module ActionController
  class Bare < Metal
    abstract!

    module Compabitility
      def cache_store; end
      def cache_store=(*); end
      def assets_dir=(*); end
      def javascripts_dir=(*); end
      def stylesheets_dir=(*); end
      def page_cache_directory=(*); end
      def asset_path=(*); end
      def asset_host=(*); end
      def relative_url_root=(*); end
      def perform_caching=(*); end
      def helpers_path=(*); end
      def allow_forgery_protection=(*); end
      def helper_method(*); end
      def helper(*); end
    end

    extend Compabitility

    def self.without_modules(*modules)
      modules = modules.map do |m|
        m.is_a?(Symbol) ? ActionController.const_get(m) : m
      end

      MODULES - modules
    end

    MODULES = [
      HideActions,
      UrlFor,
      Redirecting,
      Rendering,
      Renderers::All,
      ConditionalGet,
      RackDelegation,

      ForceSSL,
      DataStreaming,

      # Before callbacks should also be executed the earliest as possible, so
      # also include them at the bottom.
      AbstractController::Callbacks,

      # Append rescue at the bottom to wrap as much as possible.
      Rescue,

      # Add instrumentations hooks at the bottom, to ensure they instrument
      # all the methods properly.
      Instrumentation
    ]

    MODULES.each do |mod|
      include mod
    end

    ActiveSupport.run_load_hooks(:action_controller, self)
  end
end