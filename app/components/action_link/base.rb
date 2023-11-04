# frozen_string_literal: true

module ActionLink
  # A component that every action link inherits from.
  # It adds the API that all action links have in common.
  class Base < ApplicationComponent
    # The following options are common for all subclasses.

    # Authorization
    option :current_user # User passed to the policy
    option :policy_subject, as: :manual_policy_subject, default: -> {} # Record passed to the policy
    option :policy_context, as: :manual_policy_context, default: -> {} # Optional context for policy
    option :policy_library, as: :manual_policy_library, default: -> {}

    # Visualization
    option :icon, default: -> {}

    # The following options may vary for different subclasses.
    option :url, default: -> {}
    option :model, as: :manual_model, default: -> {}
    option :title, as: :manual_title, default: -> {}
    option :class, as: :css_class, default: -> {}
    option :data, default: -> {}

    def permission?
      _policy.public_send(:"#{_action}?")
    end

    # Allows you to turn off the icon.
    def icon?
      icon != false
    end

    def icon_tag(name)
      helpers.content_tag :i, nil,
                          class: "o-acticon o-acticon--#{name.to_s.dasherize}"
    end

    def options
      {
        title: _title,
        class: _class,
        data:,
        target: _target
      }
    end

    private

    # Options for `link_to`

    def _title
      t(_i18n_title_key, subject: sanitized_title_subject)
    end

    def _class
      ['c-action-link', css_class].join(' ')
    end

    def _target
      :_blank if url.to_s.start_with?('http')
    end

    # Helpers

    def _model
      candidate = manual_model
      candidate ||= url.last if url.is_a?(Array)

      candidate.respond_to?(:model_name) ||
        raise(MissingModelError, "Model `#{candidate.inspect}` must respond to #model_name")

      candidate
    end

    def sanitized_title_subject
      strip_tags(manual_title).presence ||
        strip_tags(_model.model_name.human)
    end

    # Below this point, strictly internal to this superclass.
    # If you find yourself overwriting any of these methods, question the concept.
    # Don't call these methods from the view, either.

    # Converts a class like `::ActionLink::New` to the symbol `:new`.
    def _action
      @_action ||= self.class.name[12..].underscore.to_sym
    end

    def _i18n_title_key
      "action_link_component.titles.#{_action}"
    end

    def _policy_subject
      manual_policy_subject ||
        _model ||
        raise("Expected a policy subject #{self}")
    end

    def _policy_library
      manual_policy_library || :auto
    end

    def _policy
      if (_policy_library == :auto && defined?(::ActionPolicy)) || _policy_library == :action_policy
        _policy_from_action_policy
      elsif (_policy_library == :auto && defined?(::Pundit)) || _policy_library == :pundit
        _policy_from_pundit
      else
        _policy_from_proc
      end
    end

    def _policy_from_action_policy
      ::ActionPolicy.lookup(_policy_subject).new(_policy_subject, user: current_user)
    end

    def _policy_from_pundit
      ::Pundit.policy!(current_user, _policy_subject)
    end

    def _policy_from_proc
      manual_policy_library.call(current_user:,
                                 policy_subject: _policy_subject,
                                 policy_context: manual_policy_context)
    end
  end
end
