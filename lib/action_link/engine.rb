# frozen_string_literal: true

require 'rails/engine'
require 'dry-initializer'

module ActionLink
  # :nodoc:
  class Engine < ::Rails::Engine
    isolate_namespace ActionLink

    initializer "action_link.assets" do |app|
      app.config.assets.paths << File.expand_path("../app/assets/stylesheets", __dir__)
    end

    config.to_prepare do
      # Our ActionLink components are subclasses of `ViewComponent::Base`.
      # When `ViewComponent::Base` is subclassed, two things happen:
      #
      #   1. Rails routes are included into the component
      #   2. The ViewComponent configuration is accessed
      #
      # So we can only require our components, once Rails has booted
      # AND the view_component gem has been fully initialized (configured).
      #
      # That's right here and now.
      require_relative '../../app/components/action_link/application_component'
      require_relative '../../app/components/action_link/base'
      require_relative '../../app/components/action_link/destroy'
      require_relative '../../app/components/action_link/edit'
      require_relative '../../app/components/action_link/new'
      require_relative '../../app/components/action_link/show'
    end
  end
end
