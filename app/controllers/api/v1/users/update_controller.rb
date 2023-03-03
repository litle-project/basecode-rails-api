class Api::V1::Users::UpdateController < ApplicationController
  def index
    return processing()
  end

  private
  def processing
    begin
      update = nil
      message = "No data found with id: #{params[:id]}"
      user = User
        .select(User.column_names - ['password', 'created_at', 'deleted_at'])
        .where(id: params[:id])
        .first
      
      if user
        user.update(
          name: params[:name],
          email: params[:email],
          phone_number: params[:phone]
        )

        message = user.errors.full_messages.first
      end


      if !update || !user
        render json: { code: 422, message: message, data: nil }, status: :unprocessable_entity
      else
        render json: { code: 200, message: 'OK', data: user }
      end
    rescue => exception
      render json: { code: 500, message: exception.message, data: nil }, status: :internal_server_error
    end
  end
end