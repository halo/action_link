# frozen_string_literal: true

module ActionLink
  # An action link that indicates deleting a new record.
  class Destroy < Base
    ICON = 'times-circle'

    erb_template <<~ERB.gsub("\n", '')
      <% if permission? %>
      <%= link_to(url, **options) do %>
      <%= content %>
      <% if icon? %><%= ' ' %><%= icon_tag ::ActionLink::Destroy::ICON %><% end %>
      <% end %>
      <% else %>
      <%= content %>
      <% end %>
    ERB

    option :url
    option :confirmation, as: :manual_confirmation, default: -> {}
    option :confirmation_subject, default: -> {}
    option :associative, default: -> { false }

    def i18n_title_key
      return 'action_link_component.titles.unassign' if associative

      super
    end

    def confirmation
      return manual_confirmation if manual_confirmation

      I18n.t(i18n_confirmation_key,
             subject: strip_tags(confirmation_subject || default_confirmation_subject))
    end

    def http_method
      :delete
    end

    private

    def i18n_confirmation_key
      if associative
        'action_link_component.confirmations.unassign'
      else
        'action_link_component.confirmations.destroy'
      end
    end
  end
end
