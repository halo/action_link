# frozen_string_literal: true

class OrangeModel
  include ActiveModel::API

  def id
    42
  end

  def persisted?
    true
  end
end

class RedModel
  include ActiveModel::API
end

class OrangeModelPolicy < ActionPolicy::Base
  def show?
    user == :yes
  end
end

class TestShow < ViewComponent::TestCase
  def test_disallowed
    model = OrangeModel.new
    current_user = :no

    component = ActionLink::Show.new(url: [:sales, model], current_user:)
    output = render_inline(component) { 'Hello, World!' }

    assert_equal('Hello, World!', output.to_html)
  end

  def test_allowed
    model = OrangeModel.new
    current_user = :yes

    component = ActionLink::Show.new(url: [:sales, model], current_user:)
    output = render_inline(component) { 'Hello, World!' }

    expected_html = <<~HTML.strip
      <a title="Show Orange model" class="c-action-link" href="/sales/orange_models/42">Hello, World! <i class="o-acticon o-acticon--chevron-circle-right"></i></a>
    HTML
    assert_equal(expected_html, output.to_html)
  end

  def test_i18n_model
    model = OrangeModel.new
    current_user = :yes

    component = ActionLink::Show.new(url: [:sales, model], i18n_model: RedModel, current_user:)
    output = render_inline(component) { 'Hello, World!' }

    expected_html = <<~HTML.strip
      <a title="Show Red model" class="c-action-link" href="/sales/orange_models/42">Hello, World! <i class="o-acticon o-acticon--chevron-circle-right"></i></a>
    HTML
    assert_equal(expected_html, output.to_html)
  end

  def test_invalid_i18n_model
    model = OrangeModel.new
    current_user = :yes

    component = ActionLink::Show.new(url: [:sales, model], i18n_model: 'not me', current_user:)

    assert_raises ArgumentError do
      render_inline(component) { 'Hello, World!' }
    end
  end

  def test_extra_options
    model = OrangeModel.new
    current_user = :yes

    component = ActionLink::Show.new(url: [:sales, model], current_user:,
                                     data: { nice: :thing }, class: 'is-highlighted')
    output = render_inline(component) { 'Hello, World!' }

    expected_html = <<~HTML.strip
      <a title="Show Orange model" class="c-action-link is-highlighted" data-nice="thing" href="/sales/orange_models/42">Hello, World! <i class="o-acticon o-acticon--chevron-circle-right"></i></a>
    HTML
    assert_equal(expected_html, output.to_html)
  end
end
