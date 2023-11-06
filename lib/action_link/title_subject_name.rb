# frozen_string_literal: true

module ActionLink
  # Extracts a model from the provided i18n options.
  class TitleSubjectName
    include Calls

    option :manual_title
    option :manual_i18n_model
    option :model

    def call
      manual_title || compliant_model.model_name.human
    end

    private

    def compliant_model
      compliant_manual_model || model
    end

    def compliant_manual_model
      return unless manual_i18n_model
      return manual_i18n_model if manual_i18n_model.respond_to?(:model_name)

      raise ArgumentError,
            "Expected `i18n_model:` `#{manual_i18n_model.inspect}` to respond to `#model_name`"
    end
  end
end
