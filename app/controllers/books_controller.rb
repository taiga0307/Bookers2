class BooksController < ApplicationController
  
  def index
    @book  = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book  = Book.new
    @books = Book.find(params[:id])
    @user = User.find(@books.user_id)
  end

  def create# submitを押した際に適用される
    @book = Book.new(book_params)
    # Book.new(book_params)=不完全な箱（saveがされていない為）
    @book.user_id = current_user.id
    if @book.save
    # @bookには１つのレコードが保存
    flash[:success] = 'You have creatad book successfully.'
    redirect_to book_path(@book.id)
    # (@book.id)で保存されたから次のページに飛べる
    else
      @books = Book.all
      render :index #indexに戻す
    end
  end

  def edit
    @books = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:success] = 'You have updated book successfully.'
       redirect_to book_path(@book.id)
    else
       @books = Book.all
       render :edit #indexに戻す
    end
  end

  def destroy
      @books = Book.find(params[:id])
      @books.destroy
      redirect_to books_path
  end

  private
    def book_params
        params.require(:book).permit(:title, :body)
    end
end
