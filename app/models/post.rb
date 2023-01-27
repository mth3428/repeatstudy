class Post < ApplicationRecord
  validates :tweet, presence: true


  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites

  # タグ付けの新規投稿用メソッド
  def save_tags(tags)
    # タグが存在していれば、タグの名前を配列として全て取得  #unless〜はタグが存在しているかを確認
    current_tags = self.tags.pluck(:content) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = tags - current_tags
    # 古いタグを消す
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(content: old_name)
    end
    # 新しいタグを保存
    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(content: new_name)
      self.tags << post_tag
    end
  end

  # タグ付けの更新用メソッド
  def update_tags(latest_tags)
    if self.tags.empty?
      latest_tags.each do |latest_tag|
        self.tags.find_or_create_by(content: latest_tag)
        end
    elsif latest_tags.empty?
      self.tags.each do |tag|
        self.tags.delete(tag)
      end
    else
      current_tags = self.tags.pluck(:content)
      old_tags = current_tags - latest_tags
      new_tags = latest_tags - current_tags
      old_tags.each do |old_tag|
        tag = self.tags.find_by(content: old_tag)
        self.tags.delete(tag) if tag.present?
      end

      new_tags.each do |new_tag|
        self.tags.find_or_create_by(content: new_tag)
      end
    end
  end
  # いいねしたかどうかを判断するメソッド
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end


  

  


end
