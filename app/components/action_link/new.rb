# frozen_string_literal: true

module ActionLink
  # An action link that indicates adding a new record.
  class New < Base
    ICON = 'plus-circle'

    erb_template <<~ERB.gsub("\n", '')
      <% if permission? %>
      <%= link_to(url, **options) do %>
      <%= content %>
      <% if icon? %><%= ' ' %><%= icon_tag ::ActionLink::New::ICON %><% end %>
      <% end %>
      <% else %>
      <%= content %>
      <% end %>
    ERB

    # `model:` is mandatory because `[:new, :admin, Klass]` would
    # translate to the route `[:new, :admin, :klasses]` and that's incorrect (plural vs singular).
    option :model, as: :manual_model
    option :url
    option :associative, default: -> { false }

    def i18n_title_key
      return 'action_link_component.titles.assign' if associative

      super
    end
  end
end
