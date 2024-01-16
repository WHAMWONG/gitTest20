module TodoService
  class Create
    def self.call(user_id:, title:, description: nil, due_date:, category: nil, priority:, recurrence: nil, attachments: nil)
      user = User.find_by(id: user_id)
      return { success: false, errors: ['User not found'] } unless user

      if title.blank? || due_date.blank?
        return { success: false, errors: ['Title and due date are required'] }
      end

      if due_date.past?
        return { success: false, errors: ['Due date must be in the future'] }
      end

      existing_todo = user.todos.find_by(title: title, due_date: due_date)
      return { success: false, errors: ['A todo with the same title and due date already exists'] } if existing_todo

      todo = user.todos.new(title: title, description: description, due_date: due_date, category: category, priority: priority, recurrence: recurrence)

      if attachments
        todo.attachments.attach(attachments)
      end

      if todo.save
        create_tags(todo, category) if category
        { success: true, todo: todo }
      else
        { success: false, errors: todo.errors.full_messages }
      end
    end

    private

    def self.create_tags(todo, category)
      category.split(',').each do |tag_name|
        todo.todo_tags.create(tag: tag_name.strip)
      end
    end
  end
end
