# frozen_string_literal: true

require 'rails/engine'
require 'dry-initializer'

module ActionLink
  # :nodoc:
  class Engine < ::Rails::Engine
    isolate_namespace ActionLink

    initializer "action_link.assets" do |app|
      app.config.assets.paths << Engine.root.join('app/stylesheets')
    end

    initializer 'action_link.vscode_snippets', group: :all do |app|
      app.config.after_initialize do
        vscode_dir = Rails.root.join('.vscode')
        next unless vscode_dir.directory?

        target = vscode_dir.join('action_link.code-snippets')
        source = Engine.root.join('vscode/action_link.code-snippets')

        unless target.symlink? && target.readlink.to_s == source.to_s
          FileUtils.ln_s(source, target, force: true)
        end
      end
    end

    config.to_prepare do
      # Our ActionLink components are subclasses of `ViewComponent::Base`.
      # When `ViewComponent::Base` is subclassed, two things happen:
      #
      #   1. Rails routes are included into the component
      #   2. The ViewComponent configuration is accessed
      #
      # So we can only require our components, once Rails has booted
      # AND the view_component gem has been fully initialized (configured).
      #
      # That's right here and now.
      ActiveSupport.on_load(:view_component) do
        require_relative '../../app/components/action_link/application_component'
        require_relative '../../app/components/action_link/base'
        require_relative '../../app/components/action_link/custom'
        require_relative '../../app/components/action_link/destroy'
        require_relative '../../app/components/action_link/edit'
        require_relative '../../app/components/action_link/new'
        require_relative '../../app/components/action_link/show'
        require_relative '../../app/components/action_link/download'
      end
    end
  end
end
