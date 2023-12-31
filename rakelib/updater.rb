# frozen_string_literal: true

require 'tty-spinner'
require 'zip'

module Acticons
  # Find the latest Icomoon zip-export and extract its assets.
  class Update
    def call
      generate_style_css
      generate_variables_css
      copy_fonts
    end

    private

    def source_path
      Pathname.new(Dir.home).join 'Downloads'
    end

    def target_css_path
      Pathname.new(__dir__).join('../app/assets/stylesheets/action_link')
    end

    def target_fonts_path
      Pathname.new(__dir__).join('../app/assets/fonts/action_link')
    end

    def zip
      @zip ||= ::Zip::File.open(find_zip_path)
    end

    def find_zip_path
      status = message "Looking for most recent icomoon export at `#{source_path}`"

      result = source_path.children.select do |path|
        # Iterating through acticons.zip, acticons (2).zip, etc.
        path.extname == '.zip' && path.basename.to_s.start_with?('acticons')
      end.max_by(&:mtime)

      if result
        status.success "Found `#{result.basename}`"
        return result
      end
      status.error 'Could not find acticons.zip'
      abort
    end

    def header
      "// This file is autogenerated by `rake acticons:update`\n"
    end

    def generate_style_css # rubocop:disable Metrics/AbcSize
      status = message "Generating styles.scss in #{target_css_path}"
      rows = zip.read('style.scss').split("\n")
      start_row = rows.index { |row| row.include?('.o-acticon') }
      content = "#{header}\n#{rows[start_row..].join("\n")}\n"
      content = content.gsub('unicode(', '').gsub(')', '').gsub('; ', ';')
      target_css_path.join('style.scss').write content
      status.success
    end

    def generate_variables_css
      status = message "Generating variables.scss in #{target_css_path}"
      content = "#{header}#{zip.read('variables.scss').split("\n")[2..].join("\n")}\n"
      target_css_path.join('variables.scss').write content
      status.success
    end

    def copy_fonts
      status = message "Updating acticons.ttf and acticons.woff in #{target_fonts_path}"
      target_fonts_path.join('acticons.woff').binwrite zip.read('fonts/acticons.woff')
      status.success
    end

    def message(title)
      spinner = TTY::Spinner.new ":spinner #{title}"
      spinner.auto_spin
      spinner
    end
  end
end
