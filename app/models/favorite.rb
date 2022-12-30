class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :post

  validates_uniqueness_of :post_id, scope: :user_id  # 同じ投稿を複数回お気に入り登録させないため

end
