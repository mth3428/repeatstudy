class Tag < ApplicationRecord

  has_many :post_tags, dependent: :destroy
  # post_tagsを通じて参照
  has_many :posts, through: :post_tags
end
