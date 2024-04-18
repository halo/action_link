# frozen_string_literal: true

class HouseModel
  include ActiveModel::API
end

class TreeModel
  include ActiveModel::API
end

class HouseModelPolicy < ActionPolicy::Base
  def destroy?
    user == :yes
  end
end

class TestDestroy < ViewComponent::TestCase
  def test_disallowed
    model = HouseModel.new
    current_user = :no

    component = ActionLink::Destroy.new(url: :home, model:, current_user:)
    ouput = render_inline(component) { 'Hello, World!' }

    assert_equal('Hello, World!', ouput.to_html)
  end

  def test_allowed
    model = HouseModel.new
    current_user = :yes

    component = ActionLink::Destroy.new(url: :home, model:, current_user:)
    ouput = render_inline(component) { 'Hello, World!' }

    expected_html = <<~HTML.strip
      <a title="Delete House model" class="c-action-link" data-confirm="Would you like to delete House model?" rel="nofollow" data-method="delete" href="/home">Hello, World! <i class="o-acticon o-acticon--times-circle"></i></a>
    HTML
    assert_equal(expected_html, ouput.to_html)
  end

  def test_i18n_model
    model = HouseModel.new
    current_user = :yes

    component = ActionLink::Destroy.new(url: :home, model:, i18n_model: TreeModel, current_user:)
    ouput = render_inline(component) { 'Hello, World!' }

    expected_html = <<~HTML.strip
      <a title="Delete Tree model" class="c-action-link" data-confirm="Would you like to delete Tree model?" rel="nofollow" data-method="delete" href="/home">Hello, World! <i class="o-acticon o-acticon--times-circle"></i></a>
    HTML
    assert_equal(expected_html, ouput.to_html)
  end

  def test_invalid_i18n_model
    model = HouseModel.new
    current_user = :yes

    component = ActionLink::Destroy.new(url: :home, model:, i18n_model: 'not me', current_user:)

    assert_raises ArgumentError do
      render_inline(component) { 'Hello, World!' }
    end
  end

  def test_extra_options
    model = HouseModel.new
    current_user = :yes

    component = ActionLink::Destroy.new(url: :home, model:, current_user:, data: { cool: :thing })
    ouput = render_inline(component) { 'Hello, World!' }

    expected_html = <<~HTML.strip
      <a title="Delete House model" class="c-action-link" data-cool="thing" data-confirm="Would you like to delete House model?" rel="nofollow" data-method="delete" href="/home">Hello, World! <i class="o-acticon o-acticon--times-circle"></i></a>
    HTML
    assert_equal(expected_html, ouput.to_html)
  end

  def test_associative
    model = HouseModel.new
    current_user = :yes

    component = ActionLink::Destroy.new(url: :home, model:, current_user:, associative: true)
    ouput = render_inline(component) { 'Hello, World!' }

    expected_html = <<~HTML.strip
      <a title="Unassign House model" class="c-action-link" data-confirm="Would you like to unassign House model? This action does not delete." rel="nofollow" data-method="delete" href="/home">Hello, World! <i class="o-acticon o-acticon--times-circle"></i></a>
    HTML
    assert_equal(expected_html, ouput.to_html)
  end

  def test_confirmation_subject
    model = HouseModel.new
    current_user = :yes

    component = ActionLink::Destroy.new(url: :home, model:, current_user:,
                                        confirmation_subject: 'that')
    ouput = render_inline(component) { 'Hello, World!' }

    expected_html = <<~HTML.strip
      <a title="Delete House model" class="c-action-link" data-confirm="Would you like to delete that?" rel="nofollow" data-method="delete" href="/home">Hello, World! <i class="o-acticon o-acticon--times-circle"></i></a>
    HTML
    assert_equal(expected_html, ouput.to_html)
  end

  def test_confirmation
    model = HouseModel.new
    current_user = :yes

    component = ActionLink::Destroy.new(url: :home, model:, current_user:, confirmation: 'Totally?')
    ouput = render_inline(component) { 'Hello, World!' }

    expected_html = <<~HTML.strip
      <a title="Delete House model" class="c-action-link" data-confirm="Totally?" rel="nofollow" data-method="delete" href="/home">Hello, World! <i class="o-acticon o-acticon--times-circle"></i></a>
    HTML
    assert_equal(expected_html, ouput.to_html)
  end
end
