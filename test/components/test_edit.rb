# frozen_string_literal: true

class ShelfModel
  include ActiveModel::API
end

class BottleModel
  include ActiveModel::API
end

class ShelfModelPolicy < ActionPolicy::Base
  def edit?
    user == :yes
  end
end

class TestEdit < ViewComponent::TestCase
  def test_disallowed
    model = ShelfModel.new
    current_user = :no

    component = ActionLink::Edit.new(url: :home, model:, current_user:)
    ouput = render_inline(component) { 'Hello, World!' }

    assert_equal('Hello, World!', ouput.to_html)
  end

  def test_allowed
    model = ShelfModel.new
    current_user = :yes

    component = ActionLink::Edit.new(url: :home, model:, current_user:)
    ouput = render_inline(component) { 'Hello, World!' }

    expected_html = <<~HTML.strip
      <a title="Edit Shelf model" class="c-action-link" href="/home">Hello, World! <i class="o-acticon o-acticon--pencil-circle"></i></a>
    HTML
    assert_equal(expected_html, ouput.to_html)
  end

  def test_i18n_model
    model = ShelfModel.new
    current_user = :yes

    component = ActionLink::Edit.new(url: :home, model:, i18n_model: BottleModel, current_user:)
    ouput = render_inline(component) { 'Hello, World!' }

    expected_html = <<~HTML.strip
      <a title="Edit Bottle model" class="c-action-link" href="/home">Hello, World! <i class="o-acticon o-acticon--pencil-circle"></i></a>
    HTML
    assert_equal(expected_html, ouput.to_html)
  end

  def test_invalid_i18n_model
    model = ShelfModel.new
    current_user = :yes

    component = ActionLink::Edit.new(url: :home, model:, i18n_model: 'not me', current_user:)

    assert_raises ArgumentError do
      render_inline(component) { 'Hello, World!' }
    end
  end

  def test_extra_options
    model = ShelfModel.new
    current_user = :yes

    component = ActionLink::Edit.new(url: :home, model:, current_user:, data: { cool: :thing })
    ouput = render_inline(component) { 'Hello, World!' }

    expected_html = <<~HTML.strip
      <a title="Edit Shelf model" class="c-action-link" data-cool="thing" href="/home">Hello, World! <i class="o-acticon o-acticon--pencil-circle"></i></a>
    HTML
    assert_equal(expected_html, ouput.to_html)
  end
end
