# frozen_string_literal: true

require 'test_helper'

module ActionLink
  class SuperCharge < ActionLink::Base
  end
end

class TestActionLink < Minitest::Test
  def test_action_name_derivation
    component = ActionLink::SuperCharge.new(current_user: nil)

    assert_equal :super_charge, component.send(:_action)
  end
end
