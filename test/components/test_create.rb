# frozen_string_literal: true

class PencilModel
  include ActiveModel::API
end

class MarkerModel
  include ActiveModel::API
end

class PencilModelPolicy < ActionPolicy::Base
  def create?
    user == :yes
  end
end

class TestCreate < ApplicationTest
  def test_disallowed
    model = PencilModel.new
    current_user = :no

    component = ActionLink::Create.new(url: :home, model:, current_user:)
    output = render_inline(component) { 'Hello, World!' }

    assert_equal('Hello, World!', output.to_html)
  end

  def test_allowed
    model = PencilModel.new
    current_user = :yes

    component = ActionLink::Create.new(url: :home, model:, current_user:)
    output = render_inline(component) { 'Hello, World!' }

    expected_html = <<~HTML.strip
      <a title="Create Pencil model" class="c-action-link" rel="nofollow" data-method="post" href="/home">Hello, World! <i class="o-acticon o-acticon--plus-circle"></i></a>
    HTML

    assert_equal(expected_html, output.to_html)
  end

  def test_i18n_model
    model = PencilModel.new
    current_user = :yes

    component = ActionLink::Create.new(url: :home, model:, i18n_model: MarkerModel, current_user:)
    output = render_inline(component) { 'Hello, World!' }

    expected_html = <<~HTML.strip
      <a title="Create Marker model" class="c-action-link" rel="nofollow" data-method="post" href="/home">Hello, World! <i class="o-acticon o-acticon--plus-circle"></i></a>
    HTML

    assert_equal(expected_html, output.to_html)
  end

  def test_invalid_i18n_model
    model = PencilModel.new
    current_user = :yes

    component = ActionLink::Create.new(url: :home, model:, i18n_model: 'not me', current_user:)

    assert_raises ArgumentError do
      render_inline(component) { 'Hello, World!' }
    end
  end

  def test_extra_options
    model = PencilModel.new
    current_user = :yes

    component = ActionLink::Create.new(url: :home, model:, current_user:, data: { cool: :thing })
    output = render_inline(component) { 'Hello, World!' }

    expected_html = <<~HTML.strip
      <a title="Create Pencil model" class="c-action-link" data-cool="thing" rel="nofollow" data-method="post" href="/home">Hello, World! <i class="o-acticon o-acticon--plus-circle"></i></a>
    HTML

    assert_equal(expected_html, output.to_html)
  end
end
