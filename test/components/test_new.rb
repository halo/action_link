# frozen_string_literal: true

class RocketModel
  include ActiveModel::API
end

class SpeedModel
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

  def test_i18n_model
    model = RocketModel.new
    current_user = :yes

    component = ActionLink::New.new(url: :home, model:, i18n_model: SpeedModel, current_user:)
    ouput = render_inline(component) { 'Hello, World!' }

    expected_html = <<~HTML.strip
      <a title="Add Speed model" class="c-action-link " href="/home">Hello, World! <i class="o-acticon o-acticon--plus-circle"></i></a>
    HTML
    assert_equal(expected_html, ouput.to_html)
  end

  def test_invalid_i18n_model
    model = RocketModel.new
    current_user = :yes

    component = ActionLink::New.new(url: :home, model:, i18n_model: 'not me', current_user:)

    assert_raises ArgumentError do
      render_inline(component) { 'Hello, World!' }
    end
  end

  def test_extra_options
    model = RocketModel.new
    current_user = :yes

    component = ActionLink::New.new(url: :home, model:, current_user:, data: { cool: :thing })
    ouput = render_inline(component) { 'Hello, World!' }

    expected_html = <<~HTML.strip
      <a title="Add Rocket model" class="c-action-link " data-cool="thing" href="/home">Hello, World! <i class="o-acticon o-acticon--plus-circle"></i></a>
    HTML
    assert_equal(expected_html, ouput.to_html)
  end

  def test_associative
    model = RocketModel.new
    current_user = :yes

    component = ActionLink::New.new(url: :home, model:, current_user:, associative: true)
    ouput = render_inline(component) { 'Hello, World!' }

    expected_html = <<~HTML.strip
      <a title="Assign Rocket model" class="c-action-link " href="/home">Hello, World! <i class="o-acticon o-acticon--plus-circle"></i></a>
    HTML
    assert_equal(expected_html, ouput.to_html)
  end
end
