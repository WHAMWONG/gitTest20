
class Api::TodosController < ApplicationController
  # Removed include TodoService as we will call the service directly
  before_action :authenticate_user!

  def create
    result = TodoService::Create.call(todo_params)
    if result[:success]
      render json: { status: 201, todo: result[:todo] }, status: :created
    else
      error_messages = result[:errors] # No change here, just for context
      error_status = case error_messages.first
                     when 'User not found'
                       :not_found
                     when 'Title and due date are required', 'Due date must be in the future', 'A todo with the same title and due date already exists', 'Invalid priority level'
                       :unprocessable_entity
                     else
                       :bad_request
                     end # No change here, just for context
      render json: { errors: error_messages }, status: error_status
    end
  rescue StandardError => e
    ErrorLog.create(error_message: e.message, timestamp: Time.current, user: current_user)
    render json: { errors: ['An unexpected error occurred on the server.'] }, status: :internal_server_error
  end

  private # No change here, just for context

  def todo_params
    params.permit(:user_id, :title, :description, :due_date, :category, :priority, :recurrence, :attachments) # No change here, just for context
  end

  def authenticate_user!
    # Assuming there's a method to authenticate the user
    # This should be replaced with actual authentication logic
    raise 'Unauthorized' unless current_user
  end

  def current_user
    # Stub method for current_user, should be replaced with actual user retrieval logic
    User.find_by(id: session[:user_id])
  end
end
