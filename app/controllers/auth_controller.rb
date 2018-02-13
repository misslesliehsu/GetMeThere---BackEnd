class AuthController < ApplicationController

  def login
    u = User.find_by(username: params[:username])
    if u && u.authenticate(params[:password])
      token = issue_token({ 'user_id': u.id })
      render json: {'token': token }
    else
      render json: {'error': 'Could not find or authenticate user'}, status: 401
    end
  end

  def currentUser
    user = current_user
    if user
      render json: { id: user.id, username: user.username }
    else
      render json: nil
    end
  end

  # def signup
  #   user = User.create(username: params[:username], password: params[:password])
  # end


end
