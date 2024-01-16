# frozen_string_literal: true

module TodoService
  class ValidateDueDate
    def self.call(due_date:)
      if due_date > Time.current
        { valid: true }
      else
        { valid: false, errors: I18n.t('activerecord.errors.messages.datetime_in_future') }
      end
    end
  end
end

