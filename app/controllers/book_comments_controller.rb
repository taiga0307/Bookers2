class BookCommentsController < ApplicationController
	def create
		book = Book.find(params[:book_id])
		comment = BookComment.new(book_comment_params)
        comment.user_id = current_user.id
    	# 上記２行の省略形：comment = current_user.book_comments.new(book_comment_params)
    	comment.book_id = book.id
    	comment.save
    	redirect_back(fallback_location: root_path)
	end
	def destroy
		book = Book.find(params[:book_id])
        comment = BookComment.find(params[:id])
        comment.destroy
        redirect_back(fallback_location: root_path)
        # リンク先変更
	end
	private
	def book_comment_params
    	params.require(:book_comment).permit(:comment)
	end
end
