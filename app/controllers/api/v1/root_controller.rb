class Api::V1::RootController < ActionController::API
  def index
    render json: {notice: 'Hello world!'}, status: 200
  end
end