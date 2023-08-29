# frozen_string_literal: true

require 'rails/engine'

module ActionLink
  # :nodoc:
  class Engine < ::Rails::Engine
    isolate_namespace ActionLink
  end
end
