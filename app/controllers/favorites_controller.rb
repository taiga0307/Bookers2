class FavoritesController < ApplicationController

    def create
        @book = Book.find(params[:book_id]) # viewに渡す場合@が必要。
        favorite = current_user.favorites.new(book_id: @book.id)
        favorite.save
        # 非同期通信のためリンク先削除
    end
    def destroy
        @book = Book.find(params[:book_id])
        favorite = current_user.favorites.find_by(book_id: @book.id)
        favorite.destroy
        # 非同期通信のためリンク先削除
    end
end