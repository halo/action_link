# frozen_string_literal: true

namespace :acticons do
  desc 'Applies the latest `acticons.zip` from your Downloads directory'
  task :update do
    require 'zip'
    require_relative 'updater'
    Acticons::Update.new.call
  end
end
