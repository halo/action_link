# frozen_string_literal: true

module ActionLink
  # An action link that indicates showing an existing record.
  class Custom < Base
    option :action

    erb_template <<~ERB.gsub("\n", '')
      <% if permission? %>
      <%= link_to(url, **options) do %>
      <%= content %>
      <% icon_tag :icon %>
      <% end %>
      <% else %>
      <%= content %>
      <% end %>
    ERB
  end
end
