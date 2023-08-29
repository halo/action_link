# frozen_string_literal: true

# The namespace that this gem uses.
module ActionLink
  # Lazy-loads and returns the global configuration instance.
  #
  # @example
  #   ActionLink.config.logger = MyLogger.new
  #
  # @return [ActionLink::Configuration]
  # @see .configure
  #
  def self.config
    @config ||= ::ActionLink::Configuration.new
  end

  # Yields the configuration instance.
  #
  # @example
  #   ActionLink.configure do |config|
  #     config.logger = MyLogger.new
  #   end
  #
  # @yieldparam [ActionLink::Configuration] config global configuration instance.
  # @see .config
  #
  def self.configure
    yield config
  end

  # Resets the configuration.
  #
  # @note This is useful for testing, since the configuration is global
  #   and persists across tests.
  # @api private
  #
  def self.reset!
    @configs = nil
  end
end
