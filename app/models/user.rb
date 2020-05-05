class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

#-----自分がフォローしているユーザーとの関連-----
# Relationshipモデルに対してactive_relationshipsという名前で1対多の関連付け。
  has_many :active_relationships, class_name:  "Relationship",
# active_relationshipsの外部キーをfollower_idと指定。
                                  foreign_key: "follower_id",
# 自モデルとUserモデルのインスタンスが削除されたときは、関連しているactive_relationshipsのインスタンスも削除。
                                  dependent:   :destroy
 # active_relationshipsモデルを経由した上で、followedモデル(Userモデル)に対してfollowingという名前で多対多の関連付け。
  has_many :following, through: :active_relationships, source: :followed

#-----自分がフォローされるユーザーとの関連-----
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy

  has_many :followers, through: :passive_relationships, source: :follower

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user) #user/indexの<% if user.following?(current_user) %>　(current_user)=(user)
    passive_relationships.find_by(follower_id: user.id).present?
  end

  def User.search(search, genre, direction)
      if direction == "完全一致"
         User.where(name: "#{search}") #where検索したものを全て取得。find,findby
      elsif direction == "前方一致"
         User.where(['name LIKE ?', "#{search}%"])
      elsif direction == "後方一致"
         User.where(['name LIKE ?', "%#{search}"])
      elsif direction == "部分一致"
         User.where(['name LIKE ?', "%#{search}%"])
      end
  end
end
