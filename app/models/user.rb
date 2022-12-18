class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        

        
  
  has_many :posts
  has_one_attached :image
  has_many :comments, dependent: :destroy

  validates :nickname, presence: true
  validates :introduction, presence: true

  # パスワードは半角英数字混合での入力が必須
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze

  with_options presence: true, format: { with: PASSWORD_REGEX }, on: :create do
    validates :password
  end
end
