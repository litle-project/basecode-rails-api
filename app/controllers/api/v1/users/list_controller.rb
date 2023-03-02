class Api::V1::Users::ListController < ApplicationController
  def index
    begin
      response = processing
      render json: { code: 200, message: 'OK', data: response }
    rescue => exception
      render json: { code: 500, message: exception.message, data: nil }, status: :internal_server_error
    end
  end

  private
  def processing
    begin
      users = User
        .select(User.column_names - ['password', 'created_at', 'updated_at'])
        .all
      
      if params[:keyword].present?
        users = users.where('name LIKE ?', "%#{params[:keyword]}%")
          .or(users.where('email LIKE ?', "%#{params[:keyword]}%"))
          .or(users.where('phone_number LIKE ?', "%#{params[:keyword]}%"))
      end

      users = users.paginate(page: params[:page].presence || 1, per_page: params[:limit].presence || 10)

      meta = {
        current_page: users.current_page,
        total_pages: users.total_pages,
        total_count: users.total_entries,
        per_page: users.per_page,
      }

      return { contents: users, meta: meta }
    rescue => exception
      return exception
    end
  end
end