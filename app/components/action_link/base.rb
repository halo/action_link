# frozen_string_literal: true

module ActionLink
  # A component that every action link inherits from.
  # It adds the API that all action links have in common.
  class Base < ApplicationComponent
    # The following options are common for all subclasses.

    # Authorization
    option :current_user # User passed to the policy
    option :policy_library, as: :manual_policy_library, default: -> {}
    option :policy_subject, as: :manual_policy_subject, default: -> {} # Record passed to the policy

    # Visualization
    option :icon, default: -> {}

    # The following options may vary for different subclasses.
    # Here, in the superclass, they're all defined as optional.
    option :class, as: :css_class, default: -> {}
    option :data, default: -> {}
    option :model, as: :manual_model, default: -> {}
    option :i18n_model, as: :manual_i18n_model, default: -> {}
    option :title, as: :manual_title, default: -> {}
    option :url, default: -> {}

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

    # May be accessed and/or overriden in subclasses

    def i18n_title_key
      "action_link_component.titles.#{_action}"
    end

    # Below this point, strictly internal to this superclass.
    # If you find yourself overwriting any of these methods, question the concept.
    # Don't call these methods from the view, either.

    # Options for `link_to`

    def _title
      t(i18n_title_key, subject: strip_tags(_title_subject_name))
    end

    def _class
      ['c-action-link', css_class].join(' ')
    end

    def _target
      :_blank if url.to_s.start_with?('http')
    end

    # Helpers

    def _model
      @_model ||= ::ActionLink::Model.call(manual_model:, url:)
    end

    # Converts a class like `::ActionLink::New` to the symbol `:new`.
    def _action
      @_action ||= self.class.name[12..].underscore.to_sym
    end

    def _title_subject_name
      @_title_subject_name ||= ::ActionLink::TitleSubjectName.call(
        manual_title:,
        manual_i18n_model:,
        model: _model
      )
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
        raise 'Implement me in a sane way, once it is actually needed'
      end
    end

    def _policy_from_action_policy
      ::ActionPolicy.lookup(_policy_subject).new(_policy_subject, user: current_user)
    end

    def _policy_from_pundit
      ::Pundit.policy!(current_user, _policy_subject)
    end
  end
end
