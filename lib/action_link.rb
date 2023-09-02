# frozen_string_literal: true

require 'dry/initializer'

require_relative 'action_link/version'

require 'action_link/engine' if defined?(Rails::Engine)

module ActionLink
  class Error < ::StandardError; end
  class MissingModelError < Error; end
  class SubclassNameError < Error; end
end
