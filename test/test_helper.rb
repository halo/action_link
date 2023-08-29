# frozen_string_literal: true

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

require 'view_component/base'
ViewComponent::Base.config = ViewComponent::Config.default
require 'action_controller/test_case'

require 'active_model'
require 'action_policy'

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'action_link'

require 'minitest/autorun'
