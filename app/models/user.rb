class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        

        
  
  has_many :posts
  has_one_attached :image
  has_many :comments, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post

  validates :nickname, presence: true
  validates :introduction, presence: true

  # パスワードは半角英数字混合での入力が必須
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze

  with_options presence: true, format: { with: PASSWORD_REGEX }, on: :create do
    validates :password
  end
  # いいねしたかどうかを判断するメソッド
  def favorited_by?(post_id)
    favorites.where(post_id: post_id).exists?
  end

  

end
