# frozen_string_literal: true

require 'test_helper'

class ActionLink::SuperCharge < ActionLink::Base
end

class TestActionLink < Minitest::Test
  def test_action_name_derivation
    component = ActionLink::SuperCharge.new

    assert_equal :super_charge, component.send(:_action)
  end
end
