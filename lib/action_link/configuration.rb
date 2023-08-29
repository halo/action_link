# frozen_string_literal: true

module ActionLink
  # Holds global configuration parameters.
  class Configuration
    def demand_current_user
      return @demand_current_user if defined?(@demand_current_user)

      @demand_current_user = false
    end

    attr_writer :demand_current_user
  end
end
