
json.status 201
json.todo do
  json.id @todo.id
  json.user_id @todo.user_id
  json.title @todo.title
  json.description @todo.description if @todo.description.present?
  json.due_date @todo.due_date.iso8601
  json.category @todo.category if @todo.category.present?
  json.priority @todo.priority
  json.recurrence @todo.recurrence if @todo.recurrence.present?
  json.attachments @todo.attachments.map(&:filename) if @todo.attachments.attached?
  json.created_at @todo.created_at.iso8601
  json.updated_at @todo.updated_at.iso8601
end
