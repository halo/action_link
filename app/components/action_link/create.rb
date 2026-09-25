# frozen_string_literal: true

module ActionLink
  # An action link that creates a record right away.
  class Create < Base
    ICON = 'plus-circle'

    erb_template <<~ERB.gsub("\n", '')
      <% if permission? %>
      <%= link_to(url, **options) do %>
      <%= content %>
      <% if icon? %><%= ' ' %><%= icon_tag ::ActionLink::Create::ICON %><% end %>
      <% end %>
      <% else %>
      <%= content %>
      <% end %>
    ERB

    option :url

    def http_method
      :post
    end
  end
end
