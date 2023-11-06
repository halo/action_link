# frozen_string_literal: true

module ActionLink
  # Extracts a model from the provided i18n options.
  class TitleSubject
    include Calls

    option :manual_title
    option :manual_i18n_model
    option :model

    def call
      manual_title || active_model.model_name.human
    end

    private

    def active_model
      return manual_i18n_model if manual_i18n_model.respond_to?(:model_name)
      return model if model.respond_to?(:model_name)

      raise "Expected #{manual_i18n_model.inspect} or #{model.inspect} to respond to `#model_name`"
    end
  end
end
