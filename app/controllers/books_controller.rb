class BooksController < ApplicationController
  
  def top
  end


  def index
  	@books = Book.all
  	@book = @book = Book.new
  end



  def show
  end

  def edit
  end

  def new
  	
  end

  def create
    @book = Book.new(book_params)
  	@book.user_id = current_user.id
    @book.save
    redirect_to books_path
  end

  private
    def post_image_params
        params.require(:book).permit(:title, :body)
    end
end
