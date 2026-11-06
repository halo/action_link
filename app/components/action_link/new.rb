# frozen_string_literal: true

module ActionLink
  # An action link that indicates adding a new record.
  class New < Base
    ICON = 'plus-circle'.freeze
    ICON_MULTIPLE = 'plus-plus-circle'.freeze

    erb_template <<~ERB.gsub("\n", '')
      <% if permission? %>
      <%= link_to(url, **options) do %>
      <%= content %>
      <% if icon? %><%= ' ' %><%= icon_tag icon_name %><% end %>
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
    option :multiple, default: -> { false }

    def i18n_title_key
      return 'action_link.titles.assign' if associative
      return 'action_link.titles.new_multiple' if multiple

      super
    end

    def icon_name
      return ::ActionLink::New::ICON if associative
      return ::ActionLink::New::ICON_MULTIPLE if multiple

      ::ActionLink::New::ICON
    end
  end
end
