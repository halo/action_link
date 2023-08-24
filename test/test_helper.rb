# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'action_link'

require_relative '../app/components/action_link/application_component'
require_relative '../app/components/action_link/base'

require 'minitest/autorun'
