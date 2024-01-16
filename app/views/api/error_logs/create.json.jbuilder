json.status 201
json.error_log do
  json.id @error_log.id
  json.user_id @error_log.user_id
  json.error_message @error_log.error_message
  json.timestamp @error_log.timestamp.iso8601
end
