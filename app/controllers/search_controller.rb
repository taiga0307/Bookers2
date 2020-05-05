class SearchController < ApplicationController

  def search
    @book = Book.new
    @books = Book.all
    @users = User.all

    @user_or_book = params[:genre]
    # application.html.erbで記述した検索フォーム内のgenreが渡される。
    @how_search = params[:direction]
    # application.html.erbで記述した検索フォーム内のdirectionが渡される。
    if @user_or_book == "user"
      @users = User.search(params[:search], @user_or_book, @how_search)# モデルにsearchメソッドが定義されており、コントローラーの引数がモデルに渡される。
    else
      @books = Book.search(params[:search], @user_or_book, @how_search)
    end
  end
end