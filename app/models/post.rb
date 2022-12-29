class Post < ApplicationRecord
  validates :tweet, presence: true


  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  # タグ付けの新規投稿用メソッド
  def save_tags(tags)
    current_tags = self.tags.pluck(:content) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(content: old_name)
    end

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



  

  


end
