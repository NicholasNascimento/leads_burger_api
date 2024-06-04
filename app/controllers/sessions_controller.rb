class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      render json: { id: user.id, username: user.username, admin: user.admin }, status: :ok
    else
      render json: { error: "Invalid username or password" }, status: :unauthorized
    end
  end

  def register
    user = User.new(user_params)
    if user.save
      render json: { id: user.id, username: user.username, admin: user.admin }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation)
  end
end
