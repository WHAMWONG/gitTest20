# frozen_string_literal: true

module TodoService
  class ValidateUserExistence
    def self.call(user_id:)
      User.exists?(user_id)
    end
  end
end

# End of TodoService::ValidateUserExistence
