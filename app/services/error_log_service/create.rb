# frozen_string_literal: true

module ErrorLogService
  class Create
    def initialize(user_id:, error_message:)
      @user_id = user_id
      @error_message = error_message
      validate_user!
    end

    def call
      ErrorLog.create!(
        user_id: @user_id,
        error_message: @error_message,
        timestamp: Time.current
      )
      "Error has been logged."
    end

    private

    def validate_user!
      raise ActiveRecord::RecordNotFound unless User.exists?(@user_id)
    end
  end
end
