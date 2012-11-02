$:.unshift File.expand_path("../lib", __FILE__)
require "rails"
require "rails/all"
require "action_controller/bare"
require "active_model/model"
require "active_model_serializers"
require "rest_client"

class DuNordMap < Rails::Application
  routes.append do
    resources :buildings
  end

  # Enable thread-safe mode. Production style.
  config.threadsafe!

  # Remove some unneeded middlewares
  config.middleware.delete "ActionDispatch::Flash"
  config.middleware.delete "ActionDispatch::BestStandardsSupport"
  config.middleware.delete "ActionDispatch::Static"

  # Rails need a secret token for session, cookies, etc.
  config.secret_token = "9b39a89107fb0effcfb36e06faceed9aa5309dfad0935ddcd92a713a7805476465da935d48142711a2bbf2fe1e5917c4b618d46c41545aa11f489208c2103ac6"

  # Remove the annoying message on app boot 
  config.active_support.deprecation = :log 
end

# Require everything under app dir
Dir["app/**/*.*"].each { |file| require_relative file }

# Custom configurations
SERVER_URL = "http://50.63.188.39:8080"
JsonParser = Yajl::Parser.new

# Initialize the app!
DuNordMap.initialize!
