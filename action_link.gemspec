# frozen_string_literal: true

require_relative 'lib/action_link/version'

Gem::Specification.new do |spec|
  spec.name = 'action_link'
  spec.version = ActionLink::VERSION
  spec.authors = ['halo']
  spec.email = ['github@posteo.org']

  spec.summary = 'A set of ViewComponents for common links (show, edit, delete, etc.)'
  spec.description = 'Every action has an icon, such as a "plus-sign" for the "new" action'
  spec.homepage = 'https://github.com/halo/action_link'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.2.0'

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = 'https://github.com/halo/action_link'
  spec.metadata["changelog_uri"] = 'https://github.com/halo/halo/blob/main/CHANGELOG.md'

  s.files  = Dir['CHANGELOG.md', 'LICENSE.txt', 'README.md', 'app/**/*', 'lib/**/*', 'config/**/*']

  spec.require_paths = ['lib']

  spec.add_dependency 'actionview' # Needed by `view_component`
  spec.add_dependency 'dry-initializer'
  spec.add_dependency 'view_component'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
