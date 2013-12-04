 class UsersController < ApplicationController

  def index
    @users = User.top_rated.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.visible_to(current_user)
  end  

end