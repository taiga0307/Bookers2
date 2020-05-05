class Book < ApplicationRecord
	belongs_to :user
	# 所属する
    has_many :favorites, dependent: :destroy
    def favorited_by?(user)
       favorites.where(user_id: user.id).exists?
    end
    has_many :book_comments, dependent: :destroy

	validates :title, presence: true, length: { maximum: 200 }
    validates :body, presence: true, length: { maximum: 200 }

    def Book.search(search, genre, direction)
      if direction == "完全一致"
         Book.where(['title LIKE ?  OR body LIKE ?', "#{search}", "#{search}"]) #where検索したものを全て取得。find,findby
      elsif direction == "前方一致"
         Book.where(['title LIKE ?  OR body LIKE ?', "#{search}%", "#{search}%"])
      elsif direction == "後方一致"
         Book.where(['title LIKE ?  OR body LIKE ?', "%#{search}", "%#{search}"])
      elsif direction == "部分一致"
         Book.where(['title LIKE ?  OR body LIKE ?', "%#{search}%", "%#{search}%"])
      end
  	end
end
