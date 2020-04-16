class UsersController < ApplicationController
  def index
    @book = Book.new
    @users = User.all
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end
  private 
  def user_params
    params.require(:user).permit(:name, :Introduction, :profile_image)
  end
end
