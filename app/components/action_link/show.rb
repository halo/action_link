# frozen_string_literal: true

module ActionLink
  # An action link that indicates showing an existing record.
  class Show < Base
    ICON = 'chevron-circle-right'

    erb_template <<~ERB.gsub("\n", '')
      <% if permission? %>
      <%= link_to(url, **options) do %>
      <%= content %>
      <% if icon? %><%= ' ' %><%= icon_tag ::ActionLink::Show::ICON %><% end %>
      <% end %>
      <% else %>
      <%= content %>
      <% end %>
    ERB

    option :url
  end
end
