# frozen_string_literal: true

module ActionLink
  # An action link that indicates editing an existing record.
  class Edit < Base
    ICON = 'pencil-circle'

    erb_template <<~ERB.gsub("\n", '')
      <% if permission? %>
      <%= link_to(url, **options) do %>
      <%= content %>
      <% if icon? %><%= ' ' %><%= icon_tag ::ActionLink::Edit::ICON %><% end %>
      <% end %>
      <% else %>
      <%= content %>
      <% end %>
    ERB

    option :url
  end
end
