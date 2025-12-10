# frozen_string_literal: true

module ActionLink
  # An action link that indicates downloading a file.
  class Download < Show
    ICON = 'arrow-down-circle'

    erb_template <<~ERB.gsub("\n", '')
      <% if permission? %>
      <%= link_to(url, **options.merge(target: :_blank)) do %>
      <%= content %>
      <% if icon? %><%= ' ' %><%= icon_tag ::ActionLink::Download::ICON %><% end %>
      <% end %>
      <% else %>
      <%= content %>
      <% end %>
    ERB

    option :url
  end
end
