# frozen_string_literal: true

require 'view_component'
require 'dry/initializer'

require_relative 'action_link/version'

require_relative '../app/components/action_link/application_component'
require_relative '../app/components/action_link/base'
require_relative '../app/components/action_link/new'

require 'action_link/engine' if defined?(Rails::Engine)

module ActionLink
  class Error < ::StandardError; end
  class MissingModelError < Error; end
  class SubclassNameError < Error; end
end
