class SessionsController < ApplicationController
  skip_before_action :authenticate_request, only: [:create, :register]

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      token = jwt_encode(user_id: user.id)
      render json: { id: user.id, username: user.username, admin: user.admin, token: token }, status: :ok
    else
      render json: { error: "Invalid username or password" }, status: :unauthorized
    end
  end

  def register
    user = User.new(user_params)
    if user.save
      token = jwt_encode(user_id: user.id)
      render json: { id: user.id, username: user.username, admin: user.admin, token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation)
  end
end
