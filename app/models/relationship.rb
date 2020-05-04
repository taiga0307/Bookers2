class Relationship < ApplicationRecord

	belongs_to :follower, class_name: "User" # Userモデルに対してfollowerという名前で1対1の関連付け
    belongs_to :followed, class_name: "User" # Userモデルに対してfollowedという名前で1対1の関連付け
end
