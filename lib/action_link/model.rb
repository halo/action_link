# frozen_string_literal: true

module ActionLink
  # Extracts a model from the provided model options.
  class Model
    include Calls

    option :manual_model
    option :url

    def call
      model.respond_to?(:model_name) ||
        raise(MissingModelError, "Model `#{model.inspect}` must respond to #model_name")

      model
    end

    private

    def model
      return manual_model if manual_model

      url.last if url.is_a?(Array)
    end
  end
end
