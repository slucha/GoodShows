class Api::UsersController < ApplicationController
  before_action :ensure_logged_in

  def show
    if params[:id]
      @user = User.includes(:friends,
        :reviews,
        show_shelves: :shows,
        friend_requests: :requester,
        friend_proposals: :requested).find(params[:id])
    else
      @user = User.includes(:friends,
        :reviews,
        show_shelves: :shows,
        friend_requests: :requester,
        friend_proposals: :requested).find_by_session_token(session[:session_token])
    end
    render :show
  end

  def update
    @user = User.find(params[:id])
    if @user.id == current_user.id
      @user = current_user
      @user.update_attributes(api_user_params)
      render :show
    else
      render json: { error: "You must login as this user" }, status: :forbidden
    end
  end

  def index
    @users = User.includes(:friends,
        :reviews,
        show_shelves: :shows,
        friend_requests: :requester,
        friend_proposals: :requested).all.where.not(id: current_user.id)
    render :index
  end

  def friends
    if params[:id]
      @friends = User.find(params[:id]).friends
    else
      @friends = current_user.friends
    end
    render :friends
  end

  def reviews
    
  end

  private

  def api_user_params
    params.require(:user).permit(:name, :file_url)
  end
end
