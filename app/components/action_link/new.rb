# frozen_string_literal: true

module ActionLink
  # An action link that indicates adding a new record.
  class New < Base
    # `model:` is mandatory because `[:new, :admin, Klass]` would
    # translate to the route `[:new, :admin, :klasses]` and that's incorrect (plural vs singular).
    option :model
    option :url
    option :title, as: :manual_title, default: -> {}

    # def caption
    #   safe_join([helpers.new_icon].select(&:present?), ' ')
    # end

    def options
      result = {
        title: t(i18n_key, subject: model.model_name.human),
        class: ['c-action-link', css_class].join(' '),
        data:
      }
      result[:target] = :_blank if url.to_s.start_with?('http')
      result
    end
  end
end
