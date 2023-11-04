# frozen_string_literal: true

# First, build and boot a Rails application

require 'view_component/engine'
class ActionLinkApplication < Rails::Application
end

Rails.application.routes.draw do
  resource :home
end

I18n.load_path += Dir[Rails.root.join('config/locales/*.yml')]

require 'action_controller'
class ApplicationController < ActionController::Base
end

# Second, make sure the ViewComponent gem is initialized

require 'view_component/base'
require 'action_controller/test_case'
ViewComponent::Base.config.view_component_path = File.expand_path('../app/components', __dir__)

# Third, initialize the ActionLink gem

require 'action_link/engine'
ActionLink::Engine.config.to_prepare_blocks.each(&:call)

# Now we can load whatever we need for our tests

require 'view_component/test_helpers'
require 'view_component/test_case'
require 'active_model'
require 'action_policy'

# Now we can load this very gem

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'action_link'

require 'minitest/autorun'
