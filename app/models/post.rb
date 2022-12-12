class Post < ApplicationRecord
  varidates :tweet, presence: true


  belongs_to :user
  has_one_attached :image
end
