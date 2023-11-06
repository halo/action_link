# frozen_string_literal: true

require 'dry/initializer'
require 'calls'

require 'action_link/version'
require 'action_link/model'
require 'action_link/title_subject_name'

require 'action_link/engine' if defined?(Rails::Engine)

module ActionLink
  class Error < ::StandardError; end
  class MissingModelError < Error; end
  class SubclassNameError < Error; end
end
