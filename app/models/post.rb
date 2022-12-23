class Post < ApplicationRecord
  validates :tweet, presence: true


  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
end
