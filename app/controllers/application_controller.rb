class ApplicationController < ActionController::API
  def not_found
    render json: {
      code: 404,
      message: 'Route not found',
      data: nil
    }, status: :not_found
  end
end
