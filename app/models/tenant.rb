# frozen_string_literal: true

# API users
class Tenant < ApplicationRecord
  before_create :generate_api_key

  # Check if the Tenant is throttled due to too many API requests
  # @return [Boolean]
  def throttled?
    # Reset the throttle count every day
    self.calls_today = 0 if Time.new.to_date != last_call&.to_date

    # Throttle if over 100 calls today and it has been less than 10 seconds since last call
    return true if calls_today >= 100 && Time.new - last_call < 10.seconds

    # Increment call counters
    self.calls_today += 1
    self.calls_lifetime += 1
    self.last_call = Time.new
    save!

    # Not throttled
    false
  end

  private

  # Generate a new API key for the Tenant and set the api_key attribute
  # @return [String] 32-digit hexadecimal
  def generate_api_key
    self.api_key ||= SecureRandom.hex(16)
  end
end
