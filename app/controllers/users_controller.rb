class UsersController < ApplicationController
  def index
    @book = Book.new
    @users = User.all
    @user = current_user
  end

  def edit
  	@user = User.find(params[:id])
  end

  def show
    @book  = Book.new
    @books = Book.find(params[:id])
    @user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
    if @user.update(user_params)
      # user編集画面成功時
      flash[:success] = 'You have updated user successfully.'
    redirect_to user_path(@user.id)
    else
      @user = User.all
      render :edit 
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :Introduction, :profile_image)
  end
end
