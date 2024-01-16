# frozen_string_literal: true

module TodoService
  class CheckExistingTodo
    def self.call(user_id:, title:, due_date:)
      existing_todo = Todo.where(user_id: user_id, title: title, due_date: due_date).exists?
      existing_todo
    end
  end
end

# Note: The Todo model is assumed to be already defined with the necessary associations
# and validations as per the provided ERD and related code.
# This service simply leverages the ActiveRecord query interface to check for duplicates.
