class Post < ApplicationRecord
  validates :tweet, presence: true


  belongs_to :user
  has_one_attached :image
end
