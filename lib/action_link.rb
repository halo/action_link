# frozen_string_literal: true

require 'view_component'
require 'dry/initializer'

require_relative 'action_link/version'
require_relative 'action_link/configuration'
require_relative 'action_link/configure'

require 'action_link/engine' if defined?(Rails::Engine)

# Dummy
module Rails
  def self.version
    7
  end

  def self.env
    Data.define(:development?).new(true)
  end

  def self.application; end
end

module ActionLink
  class Error < ::StandardError; end
  class MissingModelError < Error; end
  class SubclassNameError < Error; end
end
