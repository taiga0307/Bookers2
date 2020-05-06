class BooksController < ApplicationController
  before_action :authenticate_user!
  def index
    @book  = Book.new # New bookのフォーム作成の為
    @books = Book.all # book/indexの投稿一覧表示の為
  end

  def show
    @book  = Book.new # New bookのフォーム作成の為
    @bookf = Book.find(params[:id])
    @user = @bookf.user# 1つの本にむすびついているuserの情報を持ってくる
    @book_comment = BookComment.new
    @book_comments = @bookf.book_comments
  end

  def create # submitを押した際に適用される
    @book = Book.new(book_params)
    # Book.new(book_params)=不完全な箱（saveがされていない為）
    @book.user_id = current_user.id
    if @book.save
    # @bookには１つのレコードが保存
    flash[:notice] = 'You have creatad book successfully.'
    redirect_to book_path(@book.id)
    # (@book.id)で保存されたから次のページに飛べる
    else
      @books = Book.all
      render :index #indexに戻す
    end
  end

  def edit
    @books = Book.find(params[:id])
    if current_user.id != @books.user_id
    redirect_to books_path
    end
  end

  def update
    @books = Book.find(params[:id])
    if @books.update(book_params)
       redirect_to book_path(@books.id)
       flash[:success] = 'You have updated book successfully.'
    else
       render :edit #editに戻す
    end
  end

  def destroy
      @books = Book.find(params[:id])
      if @books.destroy
         redirect_to books_path
      else
         render :edit
      end
  end

  private
    def book_params
        params.require(:book).permit(:title, :body)
    end
end
