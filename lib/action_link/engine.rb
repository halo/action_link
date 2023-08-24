# frozen_string_literal: true

require 'rails/engine'

module ActionLink
  # :nodoc:
  class Engine < ::Rails::Engine
    isolate_namespace ActionLink

    # config.autoload_paths = %W[
    #   #{root}/lib
    # ]

    # config.eager_load_paths = %W[
    #   #{root}/app/components
    # ]

    # initializer "action_link_view_components.assets" do |app|
    #   app.config.assets.precompile += %w[action_link_view_components] if app.config.respond_to?(:assets)
    # end
  end
end
