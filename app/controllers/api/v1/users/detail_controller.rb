class Api::V1::Users::DetailController < ApplicationController
  def index
    begin
      data = processing()
      render json: { code: 200, message: 'OK', data: data }
    rescue => exception
      render json: { code: 500, message: exception.message, data: nil }, status: :internal_server_error
    end
  end

  private
  def processing
    detail = User
      .select(User.column_names - ['password', 'created_at', 'updated_at', 'deleted_at'])
      .where(id: params[:id])
      .first

    return response
  end
end  