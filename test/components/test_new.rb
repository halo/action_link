# frozen_string_literal: true

class RocketModel
  include ActiveModel::API
end

class RocketModelPolicy < ActionPolicy::Base
  def new?
    user == :yes
  end
end

class TestNew < ViewComponent::TestCase
  def test_disallowed
    model = RocketModel.new
    current_user = :no

    component = ActionLink::New.new(url: :home, model:, current_user:)
    ouput = render_inline(component) { 'Hello, World!' }

    assert_equal('Hello, World!', ouput.to_html)
  end

  def test_allowed
    model = RocketModel.new
    current_user = :yes

    component = ActionLink::New.new(url: :home, model:, current_user:)
    ouput = render_inline(component) { 'Hello, World!' }

    expected_html = <<~HTML.strip
      <a title="Add Rocket model" class="c-action-link " href="/home">Hello, World! <i class="o-acticon o-acticon--plus-circle"></i></a>
    HTML
    assert_equal(expected_html, ouput.to_html)
  end
end