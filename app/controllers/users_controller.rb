class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @book = Book.new
    @users = User.all
    @user = current_user
  end

  def show
    @book  = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
  	@user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user)
    end
  end

  def update
  	@user = User.find(params[:id])
    if @user.update(user_params)
      # user編集画面成功時
      redirect_to user_path(@user.id)
      flash[:notice] = 'You have updated user successfully.'
    else
      render :edit 
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
