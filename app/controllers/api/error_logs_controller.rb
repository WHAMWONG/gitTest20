module Api
  class ErrorLogsController < ApplicationController
    before_action :doorkeeper_authorize!

    rescue_from ActiveRecord::RecordNotFound, with: :user_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

    def create
      service = ErrorLogService::Create.new(
        user_id: error_log_params[:user_id],
        error_message: error_log_params[:error_message],
        timestamp: error_log_params[:timestamp]
      )
      error_log = service.call
      render json: { status: 201, error_log: error_log }, status: :created
    end

    private

    def error_log_params
      params.require(:error_log).permit(:user_id, :error_message, :timestamp)
    end

    def user_not_found
      render json: { error: "User not found." }, status: :not_found
    end

    def unprocessable_entity(exception)
      render json: { error: exception.record.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end
end
